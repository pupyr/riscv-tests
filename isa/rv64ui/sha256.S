# See LICENSE for license details.

#*****************************************************************************
# sha256.S
#-----------------------------------------------------------------------------
#
# Test sha256 instruction.
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN
main:

        #la t0, main_2
	    #pts

        addi    sp, sp, -192
        sw      ra, 188(sp)
        sw      s0, 184(sp)
        addi    s0, sp, 192
        li      a0, 0
        sw      a0, -188(s0)
        sw      a0, -12(s0)
        lui     a0, %hi(.L.str.1)
        addi    a0, a0, %lo(.L.str.1)
        sw      a0, -16(s0)
        li      a0, 1000
        sw      a0, -20(s0)
        addi    a0, s0, -168
        sw      a0, -192(s0)
        call    sha256_init
        lw      a0, -192(s0)
        lw      a1, -16(s0)
        lw      a2, -20(s0)
        call    sha256_update
        lw      a0, -192(s0)
        addi    a1, s0, -52
        call    sha256_final
        lw      a0, -188(s0)
        sw      a0, -172(s0)
        j       .LBB5_1
.LBB5_1:
        lw      a0, -16(s0)
        lw      a1, -172(s0)
        add     a0, a0, a1
        lbu     a0, 0(a0)
        beqz    a0, .LBB5_3
        j       .LBB5_2
.LBB5_2:
        lw      a0, -16(s0)
        lw      a1, -172(s0)
        addi    a2, a1, 1
        sw      a2, -172(s0)
        add     a0, a0, a1
        lbu     a0, 0(a0)
        call    call_print
        j       .LBB5_1
.LBB5_3:
        li      a0, 10
        call    call_print
        li      a0, 0
        sw      a0, -176(s0)
        j       .LBB5_4
.LBB5_4:
        lw      a1, -176(s0)
        li      a0, 31
        blt     a0, a1, .LBB5_13
        j       .LBB5_5
.LBB5_5:
        lw      a1, -176(s0)
        addi    a0, s0, -52
        add     a1, a1, a0
        lbu     a1, 0(a1)
        srli    a1, a1, 4
        sw      a1, -180(s0)
        lw      a1, -176(s0)
        add     a0, a0, a1
        lbu     a0, 0(a0)
        andi    a0, a0, 15
        sw      a0, -184(s0)
        lw      a1, -180(s0)
        li      a0, 9
        blt     a0, a1, .LBB5_7
        j       .LBB5_6
.LBB5_6:
        lw      a0, -180(s0)
        addi    a0, a0, 48
        andi    a0, a0, 255
        call    call_print
        j       .LBB5_8
.LBB5_7:
        lw      a0, -180(s0)
        addi    a0, a0, 87
        andi    a0, a0, 255
        call    call_print
        j       .LBB5_8
.LBB5_8:
        lw      a1, -184(s0)
        li      a0, 9
        blt     a0, a1, .LBB5_10
        j       .LBB5_9
.LBB5_9:
        lw      a0, -184(s0)
        addi    a0, a0, 48
        andi    a0, a0, 255
        call    call_print
        j       .LBB5_11
.LBB5_10:
        lw      a0, -184(s0)
        addi    a0, a0, 87
        andi    a0, a0, 255
        call    call_print
        j       .LBB5_11
.LBB5_11:
        j       .LBB5_12
.LBB5_12:
        lw      a0, -176(s0)
        addi    a0, a0, 1
        sw      a0, -176(s0)
        j       .LBB5_4
.LBB5_13:
        li      a0, 10
        call    call_print
        li      a0, 0
        lw      ra, 188(sp)
        lw      s0, 184(sp)
        addi    sp, sp, 192

        #ptw
        j pass


prepareM:
        addi    sp, sp, -16
        sw      ra, 12(sp)
        sw      s0, 8(sp)
        addi    s0, sp, 16
        li      a0, 16
        sw      a0, -12(s0)
        j       .LBB0_1
.LBB0_1:
        lw      a1, -12(s0)
        li      a0, 63
        blt     a0, a1, .LBB0_4
        j       .LBB0_2
.LBB0_2:
        lw      a1, -12(s0)
        lui     a0, %hi(m)
        addi    a0, a0, %lo(m)
        slli    a1, a1, 2
        add     a1, a1, a0
        lw      a2, -8(a1)
        srli    a3, a2, 17
        slli    a0, a2, 15
        or      a0, a0, a3
        srli    a4, a2, 19
        slli    a3, a2, 13
        or      a3, a3, a4
        xor     a0, a0, a3
        srli    a2, a2, 10
        xor     a0, a0, a2
        lw      a2, -28(a1)
        add     a0, a0, a2
        lw      a3, -60(a1)
        srli    a4, a3, 7
        slli    a2, a3, 25
        or      a2, a2, a4
        srli    a5, a3, 18
        slli    a4, a3, 14
        or      a4, a4, a5
        xor     a2, a2, a4
        srli    a3, a3, 3
        xor     a2, a2, a3
        add     a0, a0, a2
        lw      a2, -64(a1)
        add     a0, a0, a2
        sw      a0, 0(a1)
        j       .LBB0_3
.LBB0_3:
        lw      a0, -12(s0)
        addi    a0, a0, 1
        sw      a0, -12(s0)
        j       .LBB0_1
.LBB0_4:
        lw      ra, 12(sp)
        lw      s0, 8(sp)
        addi    sp, sp, 16
        ret

sha256_init:
        addi    sp, sp, -16
        sw      ra, 12(sp)
        sw      s0, 8(sp)
        addi    s0, sp, 16
        sw      a0, -12(s0)
        lw      a1, -12(s0)
        li      a0, 0
        sw      a0, 64(a1)
        lw      a1, -12(s0)
        sw      a0, 76(a1)
        sw      a0, 72(a1)
        lw      a1, -12(s0)
        lui     a0, 434334
        addi    a0, a0, 1639
        sw      a0, 80(a1)
        lw      a1, -12(s0)
        lui     a0, 767611
        addi    a0, a0, -379
        sw      a0, 84(a1)
        lw      a1, -12(s0)
        lui     a0, 247535
        addi    a0, a0, 882
        sw      a0, 88(a1)
        lw      a1, -12(s0)
        lui     a0, 677119
        addi    a0, a0, 1338
        sw      a0, 92(a1)
        lw      a1, -12(s0)
        lui     a0, 332005
        addi    a0, a0, 639
        sw      a0, 96(a1)
        lw      a1, -12(s0)
        lui     a0, 634967
        addi    a0, a0, -1908
        sw      a0, 100(a1)
        lw      a1, -12(s0)
        lui     a0, 129086
        addi    a0, a0, -1621
        sw      a0, 104(a1)
        lw      a1, -12(s0)
        lui     a0, 376333
        addi    a0, a0, -743
        sw      a0, 108(a1)
        lw      ra, 12(sp)
        lw      s0, 8(sp)
        addi    sp, sp, 16
        ret

sha256_update:
        addi    sp, sp, -32
        sw      ra, 28(sp)
        sw      s0, 24(sp)
        addi    s0, sp, 32
        sw      a0, -12(s0)
        sw      a1, -16(s0)
        sw      a2, -20(s0)
        li      a0, 0
        sw      a0, -24(s0)
        j       .LBB2_1
.LBB2_1:
        lw      a0, -24(s0)
        lw      a1, -20(s0)
        bgeu    a0, a1, .LBB2_6
        j       .LBB2_2
.LBB2_2:
        lw      a0, -16(s0)
        lw      a1, -24(s0)
        add     a0, a0, a1
        lbu     a0, 0(a0)
        lw      a1, -12(s0)
        lw      a2, 64(a1)
        add     a1, a1, a2
        sb      a0, 0(a1)
        lw      a1, -12(s0)
        lw      a0, 64(a1)
        addi    a0, a0, 1
        sw      a0, 64(a1)
        lw      a0, -12(s0)
        lw      a0, 64(a0)
        li      a1, 64
        bne     a0, a1, .LBB2_4
        j       .LBB2_3
.LBB2_3:
        lw      a1, -12(s0)
        mv      a0, a1
        call    sha256_transform
        lw      a1, -12(s0)
        lw      a0, 76(a1)
        lw      a3, 72(a1)
        addi    a2, a3, 512
        sltu    a3, a2, a3
        add     a0, a0, a3
        sw      a2, 72(a1)
        sw      a0, 76(a1)
        lw      a1, -12(s0)
        li      a0, 0
        sw      a0, 64(a1)
        j       .LBB2_4
.LBB2_4:
        j       .LBB2_5
.LBB2_5:
        lw      a0, -24(s0)
        addi    a0, a0, 1
        sw      a0, -24(s0)
        j       .LBB2_1
.LBB2_6:
        lw      ra, 28(sp)
        lw      s0, 24(sp)
        addi    sp, sp, 32
        ret

sha256_transform:
        addi    sp, sp, -80
        sw      ra, 76(sp)
        sw      s0, 72(sp)
        addi    s0, sp, 80
        sw      a0, -12(s0)
        sw      a1, -16(s0)
        li      a0, 0
        sw      a0, -52(s0)
        j       .LBB3_1
.LBB3_1:
        lw      a1, -52(s0)
        li      a0, 15
        bltu    a0, a1, .LBB3_4
        j       .LBB3_2
.LBB3_2:
        lw      a0, -16(s0)
        lw      a1, -52(s0)
        slli    a2, a1, 2
        add     a1, a0, a2
        lbu     a0, 0(a1)
        slli    a0, a0, 24
        lbu     a3, 1(a1)
        slli    a3, a3, 16
        or      a0, a0, a3
        lbu     a3, 2(a1)
        slli    a3, a3, 8
        or      a0, a0, a3
        lbu     a1, 3(a1)
        or      a0, a0, a1
        lui     a1, %hi(m)
        addi    a1, a1, %lo(m)
        add     a1, a1, a2
        sw      a0, 0(a1)
        j       .LBB3_3
.LBB3_3:
        lw      a0, -52(s0)
        addi    a0, a0, 1
        sw      a0, -52(s0)
        j       .LBB3_1
.LBB3_4:
        #call    prepareM
        la t0, main_2
	    pts

        lw      a0, -12(s0)
        lw      a0, 80(a0)
        sw      a0, -20(s0)
        lw      a0, -12(s0)
        lw      a0, 84(a0)
        sw      a0, -24(s0)
        lw      a0, -12(s0)
        lw      a0, 88(a0)
        sw      a0, -28(s0)
        lw      a0, -12(s0)
        lw      a0, 92(a0)
        sw      a0, -32(s0)
        lw      a0, -12(s0)
        lw      a0, 96(a0)
        sw      a0, -36(s0)
        lw      a0, -12(s0)
        lw      a0, 100(a0)
        sw      a0, -40(s0)
        lw      a0, -12(s0)
        lw      a0, 104(a0)
        sw      a0, -44(s0)
        lw      a0, -12(s0)
        lw      a0, 108(a0)
        sw      a0, -48(s0)
        li      a0, 0
        sw      a0, -52(s0)
        j       .LBB3_5
.LBB3_5:
        lw      a1, -52(s0)
        li      a0, 15
        bltu    a0, a1, .LBB3_8
        j       .LBB3_6
.LBB3_6:
        lw      a0, -48(s0)
        lw      a2, -36(s0)
        sw      a2, -68(s0)
        srli    a3, a2, 6
        slli    a1, a2, 26
        or      a1, a1, a3
        srli    a4, a2, 11
        slli    a3, a2, 21
        or      a3, a3, a4
        xor     a1, a1, a3
        srli    a4, a2, 25
        slli    a3, a2, 7
        or      a3, a3, a4
        xor     a1, a1, a3
        add     a0, a0, a1
        lw      a1, -40(s0)
        and     a1, a1, a2
        not     a2, a2
        lw      a3, -44(s0)
        and     a2, a2, a3
        or      a1, a1, a2
        add     a0, a0, a1
        lw      a1, -52(s0)
        slli    a2, a1, 2
        lui     a1, %hi(k)
        addi    a1, a1, %lo(k)
        add     a1, a1, a2
        lw      a1, 0(a1)
        add     a0, a0, a1
        lui     a1, %hi(m)
        addi    a1, a1, %lo(m)
        add     a1, a1, a2
        lw      a1, 0(a1)
        add     a0, a0, a1
        sw      a0, -56(s0)
        lw      a4, -20(s0)
        sw      a4, -64(s0)
        srli    a1, a4, 2
        slli    a0, a4, 30
        or      a0, a0, a1
        srli    a2, a4, 13
        slli    a1, a4, 19
        or      a1, a1, a2
        xor     a0, a0, a1
        srli    a2, a4, 22
        slli    a1, a4, 10
        or      a1, a1, a2
        xor     a0, a0, a1
        lw      a2, -24(s0)
        and     a1, a4, a2
        lw      a3, -28(s0)
        and     a4, a4, a3
        xor     a1, a1, a4
        and     a2, a2, a3
        xor     a1, a1, a2
        add     a0, a0, a1
        sw      a0, -60(s0)
        lw      a0, -44(s0)
        sw      a0, -48(s0)
        lw      a0, -40(s0)
        sw      a0, -44(s0)
        lw      a0, -36(s0)
        sw      a0, -40(s0)
        lw      a0, -32(s0)
        lw      a1, -56(s0)
        add     a0, a0, a1
        sw      a0, -36(s0)
        lw      a0, -28(s0)
        sw      a0, -32(s0)
        lw      a0, -24(s0)
        sw      a0, -28(s0)
        lw      a0, -20(s0)
        sw      a0, -24(s0)
        lw      a0, -56(s0)
        lw      a1, -60(s0)
        add     a0, a0, a1
        sw      a0, -20(s0)
        j       .LBB3_7
.LBB3_7:
        lw      a0, -52(s0)
        addi    a0, a0, 1
        sw      a0, -52(s0)
        j       .LBB3_5
.LBB3_8:
        li      a0, 16
        sw      a0, -52(s0)
        ptw
        j       .LBB3_9
.LBB3_9:
        lw      a1, -52(s0)
        li      a0, 63
        bltu    a0, a1, .LBB3_12
        j       .LBB3_10
.LBB3_10:
        lw      a0, -48(s0)
        lw      a2, -36(s0)
        sw      a2, -76(s0)
        srli    a3, a2, 6
        slli    a1, a2, 26
        or      a1, a1, a3
        srli    a4, a2, 11
        slli    a3, a2, 21
        or      a3, a3, a4
        xor     a1, a1, a3
        srli    a4, a2, 25
        slli    a3, a2, 7
        or      a3, a3, a4
        xor     a1, a1, a3
        add     a0, a0, a1
        lw      a1, -40(s0)
        and     a1, a1, a2
        not     a2, a2
        lw      a3, -44(s0)
        and     a2, a2, a3
        or      a1, a1, a2
        add     a0, a0, a1
        lw      a1, -52(s0)
        slli    a2, a1, 2
        lui     a1, %hi(k)
        addi    a1, a1, %lo(k)
        add     a1, a1, a2
        lw      a1, 0(a1)
        add     a0, a0, a1
        lui     a1, %hi(m)
        addi    a1, a1, %lo(m)
        add     a1, a1, a2
        lw      a1, 0(a1)
        add     a0, a0, a1
        sw      a0, -56(s0)
        lw      a4, -20(s0)
        sw      a4, -72(s0)
        srli    a1, a4, 2
        slli    a0, a4, 30
        or      a0, a0, a1
        srli    a2, a4, 13
        slli    a1, a4, 19
        or      a1, a1, a2
        xor     a0, a0, a1
        srli    a2, a4, 22
        slli    a1, a4, 10
        or      a1, a1, a2
        xor     a0, a0, a1
        lw      a2, -24(s0)
        and     a1, a4, a2
        lw      a3, -28(s0)
        and     a4, a4, a3
        xor     a1, a1, a4
        and     a2, a2, a3
        xor     a1, a1, a2
        add     a0, a0, a1
        sw      a0, -60(s0)
        lw      a0, -44(s0)
        sw      a0, -48(s0)
        lw      a0, -40(s0)
        sw      a0, -44(s0)
        lw      a0, -36(s0)
        sw      a0, -40(s0)
        lw      a0, -32(s0)
        lw      a1, -56(s0)
        add     a0, a0, a1
        sw      a0, -36(s0)
        lw      a0, -28(s0)
        sw      a0, -32(s0)
        lw      a0, -24(s0)
        sw      a0, -28(s0)
        lw      a0, -20(s0)
        sw      a0, -24(s0)
        lw      a0, -56(s0)
        lw      a1, -60(s0)
        add     a0, a0, a1
        sw      a0, -20(s0)
        j       .LBB3_11
.LBB3_11:
        lw      a0, -52(s0)
        addi    a0, a0, 1
        sw      a0, -52(s0)
        j       .LBB3_9
.LBB3_12:
        lw      a2, -20(s0)
        lw      a1, -12(s0)
        lw      a0, 80(a1)
        add     a0, a0, a2
        sw      a0, 80(a1)
        lw      a2, -24(s0)
        lw      a1, -12(s0)
        lw      a0, 84(a1)
        add     a0, a0, a2
        sw      a0, 84(a1)
        lw      a2, -28(s0)
        lw      a1, -12(s0)
        lw      a0, 88(a1)
        add     a0, a0, a2
        sw      a0, 88(a1)
        lw      a2, -32(s0)
        lw      a1, -12(s0)
        lw      a0, 92(a1)
        add     a0, a0, a2
        sw      a0, 92(a1)
        lw      a2, -36(s0)
        lw      a1, -12(s0)
        lw      a0, 96(a1)
        add     a0, a0, a2
        sw      a0, 96(a1)
        lw      a2, -40(s0)
        lw      a1, -12(s0)
        lw      a0, 100(a1)
        add     a0, a0, a2
        sw      a0, 100(a1)
        lw      a2, -44(s0)
        lw      a1, -12(s0)
        lw      a0, 104(a1)
        add     a0, a0, a2
        sw      a0, 104(a1)
        lw      a2, -48(s0)
        lw      a1, -12(s0)
        lw      a0, 108(a1)
        add     a0, a0, a2
        sw      a0, 108(a1)
        lw      ra, 76(sp)
        lw      s0, 72(sp)
        addi    sp, sp, 80
        ret

sha256_final:
        addi    sp, sp, -32
        sw      ra, 28(sp)
        sw      s0, 24(sp)
        addi    s0, sp, 32
        sw      a0, -12(s0)
        sw      a1, -16(s0)
        lw      a0, -12(s0)
        lw      a0, 64(a0)
        sw      a0, -20(s0)
        lw      a1, -12(s0)
        lw      a0, 64(a1)
        slli    a2, a0, 3
        lw      a0, 76(a1)
        lw      a3, 72(a1)
        add     a2, a2, a3
        sltu    a3, a2, a3
        add     a0, a0, a3
        sw      a2, 72(a1)
        sw      a0, 76(a1)
        lw      a0, -12(s0)
        lw      a1, -20(s0)
        addi    a2, a1, 1
        sw      a2, -20(s0)
        add     a1, a1, a0
        li      a0, 128
        sb      a0, 0(a1)
        lw      a0, -20(s0)
        li      a1, 57
        bltu    a0, a1, .LBB4_5
        j       .LBB4_1
.LBB4_1:
        j       .LBB4_2
.LBB4_2:
        lw      a1, -20(s0)
        li      a0, 63
        bltu    a0, a1, .LBB4_4
        j       .LBB4_3
.LBB4_3:
        lw      a0, -12(s0)
        lw      a1, -20(s0)
        addi    a2, a1, 1
        sw      a2, -20(s0)
        add     a1, a1, a0
        li      a0, 0
        sb      a0, 0(a1)
        j       .LBB4_2
.LBB4_4:
        lw      a1, -12(s0)
        mv      a0, a1
        call    sha256_transform
        li      a0, 0
        sw      a0, -20(s0)
        j       .LBB4_5
.LBB4_5:
        j       .LBB4_6
.LBB4_6:
        lw      a1, -20(s0)
        li      a0, 55
        bltu    a0, a1, .LBB4_8
        j       .LBB4_7
.LBB4_7:
        lw      a0, -12(s0)
        lw      a1, -20(s0)
        addi    a2, a1, 1
        sw      a2, -20(s0)
        add     a1, a1, a0
        li      a0, 0
        sb      a0, 0(a1)
        j       .LBB4_6
.LBB4_8:
        lw      a1, -12(s0)
        lbu     a0, 79(a1)
        sb      a0, 56(a1)
        lw      a1, -12(s0)
        lbu     a0, 78(a1)
        sb      a0, 57(a1)
        lw      a1, -12(s0)
        lbu     a0, 77(a1)
        sb      a0, 58(a1)
        lw      a1, -12(s0)
        lbu     a0, 76(a1)
        sb      a0, 59(a1)
        lw      a1, -12(s0)
        lbu     a0, 75(a1)
        sb      a0, 60(a1)
        lw      a1, -12(s0)
        lbu     a0, 74(a1)
        sb      a0, 61(a1)
        lw      a1, -12(s0)
        lbu     a0, 73(a1)
        sb      a0, 62(a1)
        lw      a1, -12(s0)
        lbu     a0, 72(a1)
        sb      a0, 63(a1)
        lw      a1, -12(s0)
        mv      a0, a1
        call    sha256_transform
        li      a0, 0
        sw      a0, -20(s0)
        j       .LBB4_9
.LBB4_9:
        lw      a1, -20(s0)
        li      a0, 7
        bltu    a0, a1, .LBB4_12
        j       .LBB4_10
.LBB4_10:
        lw      a0, -12(s0)
        lw      a1, -20(s0)
        slli    a2, a1, 2
        add     a0, a0, a2
        lbu     a0, 83(a0)
        lw      a1, -16(s0)
        add     a1, a1, a2
        sb      a0, 0(a1)
        lw      a0, -12(s0)
        lw      a1, -20(s0)
        slli    a1, a1, 2
        add     a0, a0, a1
        lhu     a0, 82(a0)
        lw      a2, -16(s0)
        add     a1, a1, a2
        sb      a0, 1(a1)
        lw      a0, -12(s0)
        lw      a1, -20(s0)
        slli    a1, a1, 2
        add     a0, a0, a1
        lw      a0, 80(a0)
        srli    a0, a0, 8
        lw      a2, -16(s0)
        add     a1, a1, a2
        sb      a0, 2(a1)
        lw      a0, -12(s0)
        lw      a1, -20(s0)
        slli    a1, a1, 2
        add     a0, a0, a1
        lw      a0, 80(a0)
        lw      a2, -16(s0)
        add     a1, a1, a2
        sb      a0, 3(a1)
        j       .LBB4_11
.LBB4_11:
        lw      a0, -20(s0)
        addi    a0, a0, 1
        sw      a0, -20(s0)
        j       .LBB4_9
.LBB4_12:
        lw      ra, 28(sp)
        lw      s0, 24(sp)
        addi    sp, sp, 32
        ret

call_print:
        lui a6, 0xf0000
	    sw a0, 0(a6)
        ret

  TEST_PASSFAIL

main_2:		
	    addi 	sp, sp, -1000
        call    prepareM
        pte
        j pass


RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN
  TEST_DATA

    m:
        .zero   256

    .L.str.1:
        .zero   1024
        .asciz  "Hello!"
    
.balign 4
    k:
        .word   1116352408
        .word   1899447441
        .word   3049323471
        .word   3921009573
        .word   961987163
        .word   1508970993
        .word   2453635748
        .word   2870763221
        .word   3624381080
        .word   310598401
        .word   607225278
        .word   1426881987
        .word   1925078388
        .word   2162078206
        .word   2614888103
        .word   3248222580
        .word   3835390401
        .word   4022224774
        .word   264347078
        .word   604807628
        .word   770255983
        .word   1249150122
        .word   1555081692
        .word   1996064986
        .word   2554220882
        .word   2821834349
        .word   2952996808
        .word   3210313671
        .word   3336571891
        .word   3584528711
        .word   113926993
        .word   338241895
        .word   666307205
        .word   773529912
        .word   1294757372
        .word   1396182291
        .word   1695183700
        .word   1986661051
        .word   2177026350
        .word   2456956037
        .word   2730485921
        .word   2820302411
        .word   3259730800
        .word   3345764771
        .word   3516065817
        .word   3600352804
        .word   4094571909
        .word   275423344
        .word   430227734
        .word   506948616
        .word   659060556
        .word   883997877
        .word   958139571
        .word   1322822218
        .word   1537002063
        .word   1747873779
        .word   1955562222
        .word   2024104815
        .word   2227730452
        .word   2361852424
        .word   2428436474
        .word   2756734187
        .word   3204031479
        .word   3329325298

RVTEST_DATA_END