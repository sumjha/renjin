package org.renjin.gcc.codegen.expr;

import org.objectweb.asm.MethodVisitor;
import org.objectweb.asm.Opcodes;
import org.objectweb.asm.Type;

/**
 * Writes the code to dereference a pointer expression
 */
public class MemRefGenerator implements PrimitiveGenerator, LValueGenerator {
  
  private PtrGenerator ptrGenerator;

  public MemRefGenerator(ExprGenerator ptrGenerator) {
    this.ptrGenerator = (PtrGenerator) ptrGenerator;
  }

  @Override
  public Type primitiveType() {
    return ptrGenerator.baseType();
  }

  @Override
  public void emitPush(MethodVisitor mv) {
    // push array onto stack
    ptrGenerator.emitPushArray(mv);
    ptrGenerator.emitPushOffset(mv);
    mv.visitInsn(ptrGenerator.baseType().getOpcode(Opcodes.IALOAD));
  }

  @Override
  public void emitStore(MethodVisitor mv, ExprGenerator valueGenerator) {
    
    // XASTORE = arrayref, index, value
    
    ptrGenerator.emitPushArray(mv);
    ptrGenerator.emitPushOffset(mv);
    
    // push the value to assign
    PrimitiveGenerator primitiveGenerator = (PrimitiveGenerator) valueGenerator;
    primitiveGenerator.emitPush(mv);
    
    mv.visitInsn(primitiveType().getOpcode(Opcodes.IASTORE));
  }
}
