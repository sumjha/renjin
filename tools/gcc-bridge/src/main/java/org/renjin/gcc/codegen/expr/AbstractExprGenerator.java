package org.renjin.gcc.codegen.expr;

import org.objectweb.asm.MethodVisitor;
import org.objectweb.asm.Opcodes;
import org.objectweb.asm.Type;
import org.renjin.gcc.codegen.WrapperType;
import org.renjin.gcc.codegen.call.MallocGenerator;
import org.renjin.gcc.gimple.type.GimplePrimitiveType;

public abstract class AbstractExprGenerator implements ExprGenerator {

  @Override
  public ExprGenerator valueOf() {
    throw new UnsupportedOperationException(String.format("%s [%s] cannot be dereferenced",
        toString(), getClass().getSimpleName()));
  }

  @Override
  public ExprGenerator addressOf() {
    throw new UnsupportedOperationException(String.format("%s [%s] is not addressable",
        toString(), getClass().getSimpleName()));
  }

  @Override
  public ExprGenerator realPart() {
    throw new UnsupportedOperationException(String.format("%s [%s] is not a complex number value",
        toString(), getClass().getSimpleName()));
  }

  @Override
  public ExprGenerator imaginaryPart() {
    throw new UnsupportedOperationException(String.format("%s [%s] is not a complex number value",
        toString(), getClass().getSimpleName()));  }

  @Override
  public ExprGenerator elementAt(ExprGenerator indexGenerator) {
    throw new UnsupportedOperationException(String.format("%s [%s] is not an array", 
        toString(), getClass().getSimpleName()));
  }


  @Override
  public final Type getJvmPrimitiveType() {
    if(getGimpleType() instanceof GimplePrimitiveType) {
      return ((GimplePrimitiveType) getGimpleType()).jvmType();
    } else {
      throw new UnsupportedOperationException(String.format("%s [%s] is not a value of primitive type (%s)",
          toString(), getClass().getSimpleName(), getGimpleType()));
    }
  }
  
  @Override
  public void emitPrimitiveValue(MethodVisitor mv) {
    throw new UnsupportedOperationException(String.format("%s [%s] is not a value type",
        toString(), getClass().getSimpleName()));
  
  }
  
  @Override
  public void emitPushPtrArrayAndOffset(MethodVisitor mv) {
    throw new UnsupportedOperationException(String.format("%s [%s] is not a [array-backed] pointer type",
        toString(), getClass().getSimpleName()));  
  }

  @Override
  public void emitPushPtrArray(MethodVisitor mv) {
    emitPushPtrArrayAndOffset(mv);
    mv.visitInsn(Opcodes.POP);
  }

  @Override
  public void emitPushMethodHandle(MethodVisitor mv) {
    throw new UnsupportedOperationException(String.format("%s [%s] is not a [reference-backed] pointer type",
        toString(), getClass().getSimpleName()));
  }

  @Override
  public WrapperType getPointerType() {
    throw new UnsupportedOperationException(String.format("%s [%s] is not a pointer type",
        toString(), getClass().getSimpleName())); 
  }

  @Override
  public void emitPushPointerWrapper(MethodVisitor mv) {
    getPointerType().emitPushNewWrapper(mv, this);
  }

  @Override
  public void emitPushComplexAsArray(MethodVisitor mv) {
    Type partType = realPart().getJvmPrimitiveType();
    
    mv.visitInsn(Opcodes.ICONST_2);
    MallocGenerator.emitNewArray(mv, partType);
    mv.visitInsn(Opcodes.DUP);
    mv.visitInsn(Opcodes.ICONST_0);
    realPart().emitPrimitiveValue(mv);
    mv.visitInsn(partType.getOpcode(Opcodes.IASTORE));
    mv.visitInsn(Opcodes.DUP);
    mv.visitInsn(Opcodes.ICONST_1);
    imaginaryPart().emitPrimitiveValue(mv);
    mv.visitInsn(partType.getOpcode(Opcodes.IASTORE));
  }

  @Override
  public void emitStore(MethodVisitor mv, ExprGenerator valueGenerator) {
    throw new UnsupportedOperationException(String.format("Cannot store value to %s [%s]",
        toString(), getClass().getSimpleName())); 
  }


  @Override
  public boolean isConstantIntEqualTo(int value) {
    return false;
  }

}
