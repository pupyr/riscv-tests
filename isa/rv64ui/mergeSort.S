# See LICENSE for license details.

#*****************************************************************************
# addi.S
#-----------------------------------------------------------------------------
#
# Test addi instruction.
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN
  
main:		
	
	call printer
	
	#la t0, main_2
	#pts
	
        addi    sp, sp, -16
        sw      ra, 12(sp)
        sw      s0, 8(sp)
        addi    s0, sp, 16
        lui     a0, %hi(mass)
        addi    a0, a0, %lo(mass)
        la	a1, mass_size
        lw      a1, 0(a1)
        srli	a1, a1, 1
        li	a2, 1
        call    mergeSort
	
	#beq	zero, zero, end_without_ptu
	lui     a0, %hi(mass)
        addi    a0, a0, %lo(mass)
        la	 a1, mass_size
        lw      a1, 0(a1)
        slli	 a1, a1, 1
	add	 a0, a0, a1
	srli	 a1, a1, 2
        li	 a2, 1
        call    mergeSort
        
end_without_ptu:
	
        #ptw
        
        lui     a0, %hi(mass)
        addi    a0, a0, %lo(mass)
        la	a1, mass_size
        lw      a1, 0(a1)
        li	a2, 0
	call mergeSort
        
	li      a0, 0
        lw      ra, 12(sp)
        lw      s0, 8(sp)
        addi    sp, sp, 16
        call printer
        j pass
  
mergeSort:
        addi    sp, sp, -48
        sw      ra, 44(sp)
        sw      s0, 40(sp)
        addi    s0, sp, 48
        sw      a0, -12(s0)
        sw      a1, -16(s0)
        lw      a0, -16(s0)
        li      a1, 2
        beq	a2, zero, .LBB1_2
        blt     a0, a1, .LBB1_2
        j       .LBB1_1
.LBB1_1:
        lw      a0, -12(s0)
        lw      a1, -16(s0)
        srli    a2, a1, 31
        add     a1, a1, a2
        srai    a1, a1, 1
        li	a2, 1
        call    mergeSort
        lw      a0, -12(s0)
        lw      a1, -16(s0)
        srli    a2, a1, 31
        add     a2, a2, a1
        srai    a2, a2, 1
        slli    a3, a2, 2
        add     a0, a0, a3
        sub     a1, a1, a2
        li	a2, 1
        call    mergeSort
        j       .LBB1_2
.LBB1_2:
        li      a0, 0
        sw      a0, -20(s0)
        lw      a1, -16(s0)
        srli    a2, a1, 31
        add     a1, a1, a2
        srai    a1, a1, 1
        sw      a1, -24(s0)
        sw      a0, -28(s0)
        lw      a0, -16(s0)
        mv      a1, sp
        sw      a1, -32(s0)
        slli    a1, a0, 2
        addi    a1, a1, 15
        andi    a2, a1, -16
        mv      a1, sp
        sub     a1, a1, a2
        sw      a1, -44(s0)
        mv      sp, a1
        sw      a0, -36(s0)
        j       .LBB1_3
.LBB1_3:
        lw      a0, -20(s0)
        lw      a1, -16(s0)
        srli    a2, a1, 31
        add     a1, a1, a2
        srai    a1, a1, 1
        li      a2, 1
        sw      a2, -48(s0)
        blt     a0, a1, .LBB1_5
        j       .LBB1_4
.LBB1_4:
        lw      a0, -24(s0)
        lw      a1, -16(s0)
        slt     a0, a0, a1
        sw      a0, -48(s0)
        j       .LBB1_5
.LBB1_5:
        lw      a0, -48(s0)
        andi    a0, a0, 1
        beqz    a0, .LBB1_12
        j       .LBB1_6
.LBB1_6:
        lw      a0, -20(s0)
        lw      a1, -16(s0)
        srli    a2, a1, 31
        add     a1, a1, a2
        srai    a1, a1, 1
        beq     a0, a1, .LBB1_9
        j       .LBB1_7
.LBB1_7:
        lw      a0, -24(s0)
        lw      a1, -16(s0)
        bge     a0, a1, .LBB1_10
        j       .LBB1_8
.LBB1_8:
        lw      a0, -12(s0)
        lw      a1, -20(s0)
        slli    a1, a1, 2
        add     a1, a1, a0
        lw      a1, 0(a1)
        lw      a2, -24(s0)
        slli    a2, a2, 2
        add     a0, a0, a2
        lw      a0, 0(a0)
        bge     a0, a1, .LBB1_10
        j       .LBB1_9
.LBB1_9:
        lw      a1, -44(s0)
        lw      a0, -12(s0)
        lw      a2, -24(s0)
        addi    a3, a2, 1
        sw      a3, -24(s0)
        slli    a2, a2, 2
        add     a0, a0, a2
        lw      a0, 0(a0)
        lw      a2, -28(s0)
        addi    a3, a2, 1
        sw      a3, -28(s0)
        slli    a2, a2, 2
        add     a1, a1, a2
        sw      a0, 0(a1)
        j       .LBB1_11
.LBB1_10:
        lw      a1, -44(s0)
        lw      a0, -12(s0)
        lw      a2, -20(s0)
        addi    a3, a2, 1
        sw      a3, -20(s0)
        slli    a2, a2, 2
        add     a0, a0, a2
        lw      a0, 0(a0)
        lw      a2, -28(s0)
        addi    a3, a2, 1
        sw      a3, -28(s0)
        slli    a2, a2, 2
        add     a1, a1, a2
        sw      a0, 0(a1)
        j       .LBB1_11
.LBB1_11:
        j       .LBB1_3
.LBB1_12:
        li      a0, 0
        sw      a0, -40(s0)
        j       .LBB1_13
.LBB1_13:
        lw      a0, -40(s0)
        lw      a1, -16(s0)
        bge     a0, a1, .LBB1_16
        j       .LBB1_14
.LBB1_14:
        lw      a0, -44(s0)
        lw      a1, -40(s0)
        slli    a2, a1, 2
        add     a0, a0, a2
        lw      a0, 0(a0)
        lw      a1, -12(s0)
        add     a1, a1, a2
        sw      a0, 0(a1)
        j       .LBB1_15
.LBB1_15:
        lw      a0, -40(s0)
        addi    a0, a0, 1
        sw      a0, -40(s0)
        j       .LBB1_13
.LBB1_16:
        lw      a0, -32(s0)
        mv      sp, a0
        addi    sp, s0, -48
        lw      ra, 44(sp)
        lw      s0, 40(sp)
        addi    sp, sp, 48
        ret

  TEST_PASSFAIL


printer:

        li a3, 8
        la a4, mass
        lui a6, 0xf0000
loop:
	lw a5, 0(a4)
	addi a5, a5, 48
	sw a5, 0(a6)
	addi a3, a3, -1
	addi a4, a4, 4
	bne a3, zero, loop
        li a5, 0xa
        sw a5, 0(a6)
        ret


main_2:		
	addi 	sp, sp, -1000
        addi    sp, sp, -16
        sw      ra, 12(sp)
        sw      s0, 8(sp)
        addi    s0, sp, 16
        lui     a0, %hi(mass)
        addi    a0, a0, %lo(mass)
        la	a1, mass_size
        lw      a1, 0(a1)
        slli	a1, a1, 1
        add	a0, a0, a1
        srli	a1, a1, 2
        li	a2, 1
        call    mergeSort
        li      a0, 0
        lw      ra, 12(sp)
        lw      s0, 8(sp)
        addi    sp, sp, 16
        pte
        j pass

.balign 4
inf_loop:
	addi x2, x2, 1
	j inf_loop


RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA
mass:
        .word   7
        .word   3
        .word   5
        .word   1
        .word   4
        .word   8
        .word   6
        .word   2
        .word   7
        .word   3
        .word   5
        .word   1
        .word   4
        .word   8
        .word   6
        .word   2
        .word   7
        .word   3
        .word   5
        .word   1
        .word   4
        .word   8
        .word   6
        .word   2
        .word   7
        .word   3
        .word   5
        .word   1
        .word   4
        .word   8
        .word   6
        .word   2
mass_size:
	.word 0x8
RVTEST_DATA_END
