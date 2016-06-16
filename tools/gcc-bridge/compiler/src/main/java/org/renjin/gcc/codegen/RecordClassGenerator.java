package org.renjin.gcc.codegen;

import com.google.common.io.Files;
import org.objectweb.asm.ClassVisitor;
import org.objectweb.asm.ClassWriter;
import org.objectweb.asm.Type;
import org.objectweb.asm.util.TraceClassVisitor;
import org.renjin.gcc.GimpleCompiler;
import org.renjin.gcc.InternalCompilerException;
import org.renjin.gcc.codegen.expr.*;
import org.renjin.gcc.codegen.type.FieldStrategy;
import org.renjin.gcc.codegen.var.LocalVarAllocator;
import org.renjin.gcc.gimple.type.GimpleRecordTypeDef;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.util.Collection;

import static org.objectweb.asm.Opcodes.*;


/**
 * Generates a JVM class for a {@link GimpleRecordTypeDef}
 */
public class RecordClassGenerator {

  private ClassWriter cw;
  private ClassVisitor cv;
  private StringWriter sw;
  private PrintWriter pw;
  private Type className;
  private Type superClassName;
  private Collection<FieldStrategy> fields;

  public RecordClassGenerator(Type className, Type superClassName, Collection<FieldStrategy> fields) {
    this.fields = fields;
    this.className = className;
    this.superClassName = superClassName;
  }

  public void writeClassFile(File outputDirectory) throws IOException {
    File classFile = new File(outputDirectory.getAbsolutePath() + File.separator + className.getInternalName()  + ".class");
    if(!classFile.getParentFile().exists()) {
      boolean created = classFile.getParentFile().mkdirs();
      if(!created) {
        throw new IOException("Failed to create directory for class file: " + classFile.getParentFile());
      }
    }
    Files.write(generateClassFile(), classFile);
  }

  public byte[] generateClassFile() throws IOException {

    sw = new StringWriter();
    pw = new PrintWriter(sw);
    cw = new ClassWriter(ClassWriter.COMPUTE_FRAMES | ClassWriter.COMPUTE_MAXS);
    if(GimpleCompiler.TRACE) {
      cv = new TraceClassVisitor(cw, new PrintWriter(System.out));
    } else {
      cv = cw;
    }
    cv.visit(V1_6, ACC_PUBLIC + ACC_SUPER, 
        className.getInternalName(), null,
        superClassName.getInternalName(), new String[0]);

    emitDefaultConstructor();
    emitFields();
    emitSetMethod();
    emitCloneMethod();
    cv.visitEnd();

    return cw.toByteArray();
  }

  private void emitFields() {
    for (FieldStrategy fieldStrategy : fields) {
      fieldStrategy.writeFields(cv);
    }
  }

  /**
   * Generates a method which sets *This* fields values from another Record instance
   */
  private void emitSetMethod() {
    String descriptor = Type.getMethodDescriptor(Type.VOID_TYPE, className);
    MethodGenerator mv = new MethodGenerator(cv.visitMethod(ACC_PUBLIC, "set", descriptor, null, null));
    mv.visitCode();
    
    // Local variables
    SimpleExpr thisExpr = Expressions.thisValue(className);
    SimpleExpr sourceExpr = Expressions.localVariable(className, 1);
    
    // Now copy each field member
    for (FieldStrategy field : fields) {
      try {
        LValue thisField = (LValue) field.memberExprGenerator(thisExpr);
        Expr sourceField = field.memberExprGenerator(sourceExpr);

        thisField.store(mv, sourceField);
        
      } catch (Exception e) {
        throw new InternalCompilerException("Exception generating copy code for " + className + ", field: " + field, e);
      }
    }
    
    mv.areturn(Type.VOID_TYPE);
    mv.visitMaxs(1, 1);
    mv.visitEnd();
  }
  
  private void emitCloneMethod() {
    String cloneDescriptor = Type.getMethodDescriptor(className);
    MethodGenerator mv = new MethodGenerator(cv.visitMethod(ACC_PUBLIC, "clone", cloneDescriptor, null, null));
    mv.visitCode();
    
    // Create copy
    mv.anew(className);
    mv.dup();
    mv.invokeconstructor(className);
    mv.store(1, className);
    
    
    // Set the fields from one to the other
    mv.load(1, className);
    mv.load(0, className);
    mv.invokevirtual(className, "set", Type.getMethodDescriptor(Type.VOID_TYPE, className), false);
    
    mv.load(1, className);
    mv.areturn(className);
    mv.visitMaxs(1, 1);
    mv.visitEnd();
  }


  private void emitDefaultConstructor() {
    MethodGenerator mv = new MethodGenerator(cv.visitMethod(ACC_PUBLIC, "<init>", "()V", null, null));
    mv.visitCode();
    mv.visitVarInsn(ALOAD, 0);
    mv.visitMethodInsn(INVOKESPECIAL, superClassName.getInternalName(), "<init>", "()V", false);

    for (FieldStrategy fieldStrategy : fields) {
      fieldStrategy.emitInstanceInit(mv);
    }

    mv.visitInsn(RETURN);
    mv.visitMaxs(1, 1);
    mv.visitEnd();
  }
}
