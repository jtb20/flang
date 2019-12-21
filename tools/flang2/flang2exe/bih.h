/*
 * Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
 * See https://llvm.org/LICENSE.txt for license information.
 * SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
 *
 */

#ifndef BIH_H_
#define BIH_H_

#include "symtab.h"

/**
   \file
   \brief BIH data structures and definitions
 */

typedef struct {
  SPTR label;
  int lineno;
  union {
    UINT all;
    struct {
      unsigned rd : 1;        /* memory resident -- currently always 1 */
      unsigned ft : 1;        /* falls thru */
      unsigned en : 1;        /* is a subprogram/function entry */
      unsigned ex : 1;        /* contains an external call */
      unsigned xt : 1;        /* is an exit from the subprogram/function*/
      unsigned pl : 1;        /* is pipelinable */
      unsigned ztrp : 1;      /* is the head of a zero-trip loop */
      unsigned smove : 1;     /* i386: block contains struct move
                               * i860 (temporary): unsafe to use func
                               * return registers
                               */
      unsigned nobla : 1;     /* loop count inst can't be used */
      unsigned nomerge : 1;   /* don't merge this block */
      unsigned qjsr : 1;      /* used only by the optimizer */
      unsigned head : 1;      /* bih is the head of a loop */
      unsigned tail : 1;      /* bih is the tail of a loop */
      unsigned innermost : 1; /* bih is the head of an innermost loop*/
      unsigned mexits : 1;    /* bih is the head of a loop with > 1 exit*/
      unsigned ozcr : 1;      /* bih is optimizer pro-/epi- logue (temp) */

      unsigned par : 1;       /* bih belongs to a parallel region */
      unsigned cs : 1;        /* bih is a critical section */
      unsigned streg : 1;     /* block contains stores of globally assigned
                               * registers into their assigned variables;
                               * set and cleared by the optimizer.  Flag
                               * is set irrespective of target; actual use
                               * is target-dependent.
                               */
      unsigned vpar : 1;      /* bih belongs to an auto-parallelized loop --
                               * NOT YET SET
                               */
      unsigned nodepchk2 : 1; /* nodepchk fixup - used by llvm bridge */
      unsigned nodepchk : 1;  /* nodepchk - use by llvm bridge */
      unsigned enlab : 1;     /* this bih contains entry debug label */
      unsigned parloop : 1;   /* bih is the head of a parallel loop; the loop
                               * is parallelized by vpar() or is specified by
                               * the user as a PDO.
                               */

      unsigned parsect : 1;   /* bih belongs to a parallel section */
      unsigned ujres : 1;     /* bih contains ujresidual start & count info */
      unsigned simd : 1;       /* bih contains simd code */

      unsigned ldvol : 1; /* bih contains a load from volatile space */
      unsigned stvol : 1; /* bih contains a store to volatile space */
      unsigned last : 1;  /* lexically last bih, usually same as xt */
      unsigned gasm : 1;  /* contains GASM */
    } bits;
  } flags;
  union {
    UINT all;
    struct {
      unsigned paraln : 1; /* parallelized loop split up so that the
                            * alignment of arrays on all lcpus is the
                            * same as if executed serially.
                            */
      unsigned invif : 1;  /* Used to mark a block as either created
                            * during invarif (a factor block) or as
                            * legal to apply the invarif optimization.
                            */
      unsigned noinvif : 1;
      unsigned combst : 1; /* Block contains combined stores generated by
                            * llvect.
                            */

      unsigned deletable : 1; /* This block is deletable */
      unsigned mark : 1;
      unsigned task : 1;       /* bih belongs to a task */
      unsigned resid : 1;      /* bih is the head of a residual loop */

      unsigned vcand : 1;      /* bih is the head of a vector candidate loop */
      unsigned accel : 1;      /* bih is head of an accelerator region */
      unsigned endaccel : 1;   /* bih is tail of an accelerator region */
      unsigned midiom : 1;     /* bih is head of a mem-idiom collapsed loop */
      unsigned accdata : 1;    /* bih is head of an accelerator data region */
      unsigned endaccdata : 1; /* bih is tail of an accelerator data region */
      unsigned mark2 : 1;      /* bih is reachable and not dead, if set */
      unsigned mark3 : 1;

      unsigned kernel : 1;     /* bih is head of a cuda kernel */
      unsigned endkernel : 1;  /* bih is tail of a cuda kernel */
      unsigned useful : 1;     /* bih contains useful work */
      unsigned guardee : 1;    /* is guarded by a size-zero test */
      unsigned guarder : 1;    /* zero-size check block */
      unsigned samelpcnt : 1;  /* this block and its innermost loops have
                                  same loop bound and zero-size was removed
                                  from its inner loops this block will have
                                  zero-size check.
                                */
      unsigned rpct : 1;       /* block contains RPCT altcode or the RPCT
                                *   no-conflict loop */
      unsigned rpct_confl : 1; /* block contains the RPCT conflict loop */
      unsigned rt_guarded : 1; /* block contains runtime guarded loop */
      unsigned doconc : 1;     /* bih is the head of a do concurrent loop */
    } bits;
  } flags2;
  int lpcntFrom;  /* When a loop count temp is created, record the induction
                   * variable (its nme) from which the count is created */
  int rgset;      /* set of regs live for block. Also,*/
                  /*     used in hlvect to link bih's */
  int assn;       /* index to rat applicable to block */
  int prev;       /* previous lexical block */
  int next;       /* next lexical block */
  int first;      /* first ilt in block */
  int last;       /* last ilt in block */
  int findex;     /* FIH index */
  int ftag;       /* tag used with findex for pfo, etc. */
  double blkCnt;  /* block execution count (offset of blkCnt must be a
                   * multiple of 8.
                   */
  UINT aveLpCnt;  /* average loop count */
  UINT padding;   /* to make a total of 8 bytes  */
  int branchfreq; /* percent (0<=.<=100) branch taken frequency */
  /****** BIH size must be a multiple of 8 : bihutil.c */
} BIH;

typedef struct {
  STG_MEMBERS(BIH);
  int stg_max;
  char callfg;    /* call flag */
  char parfg;     /* parallel region flag */
  char csfg;      /* critical section flag */
  char parsectfg; /* parallel section flag */
  char ldvol;     /* Volatile load flag */
  char stvol;     /* Volatile store flag */
  char qjsrfg;    /* QJSR flag */
  char gasm;      /* contains gasm */
  char taskfg;    /* task flag */
} BIHB;

#define BIH_LABEL(i) bihb.stg_base[i].label
#define BIH_LINENO(i) bihb.stg_base[i].lineno
#define BIH_FLAGS(i) bihb.stg_base[i].flags.all
#define BIH_RD(i) bihb.stg_base[i].flags.bits.rd
#define BIH_FT(i) bihb.stg_base[i].flags.bits.ft
#define BIH_EN(i) bihb.stg_base[i].flags.bits.en
#define BIH_EX(i) bihb.stg_base[i].flags.bits.ex
#define BIH_XT(i) bihb.stg_base[i].flags.bits.xt
#define BIH_LAST(i) bihb.stg_base[i].flags.bits.last
#define BIH_PL(i) bihb.stg_base[i].flags.bits.pl
#define BIH_ZTRP(i) bihb.stg_base[i].flags.bits.ztrp
#define BIH_GUARDEE(i) bihb.stg_base[i].flags2.bits.guardee
#define BIH_GUARDER(i) bihb.stg_base[i].flags2.bits.guarder
#define BIH_SAMELPCNT(i) bihb.stg_base[i].flags2.bits.samelpcnt
#define BIH_SMOVE(i) bihb.stg_base[i].flags.bits.smove
#define BIH_NOBLA(i) bihb.stg_base[i].flags.bits.nobla
#define BIH_NOMERGE(i) bihb.stg_base[i].flags.bits.nomerge
#define BIH_QJSR(i) bihb.stg_base[i].flags.bits.qjsr
#define BIH_HEAD(i) bihb.stg_base[i].flags.bits.head
#define BIH_TAIL(i) bihb.stg_base[i].flags.bits.tail
#define BIH_INNERMOST(i) bihb.stg_base[i].flags.bits.innermost
#define BIH_MEXITS(i) bihb.stg_base[i].flags.bits.mexits
#define BIH_OZCR(i) bihb.stg_base[i].flags.bits.ozcr
#define BIH_PAR(i) bihb.stg_base[i].flags.bits.par
#define BIH_CS(i) bihb.stg_base[i].flags.bits.cs
#define BIH_STREG(i) bihb.stg_base[i].flags.bits.streg
#define BIH_VPAR(i) bihb.stg_base[i].flags.bits.vpar
#define BIH_NODEPCHK(i) bihb.stg_base[i].flags.bits.nodepchk
#define BIH_NODEPCHK2(i) bihb.stg_base[i].flags.bits.nodepchk2
#define BIH_MARK(i) bihb.stg_base[i].flags2.bits.mark
#define BIH_MARK2(i) bihb.stg_base[i].flags2.bits.mark2
#define BIH_MARK3(i) bihb.stg_base[i].flags2.bits.mark3
#define BIH_USEFUL(i) bihb.stg_base[i].flags2.bits.useful

#define BIH_ENLAB(i) bihb.stg_base[i].flags.bits.enlab
#define BIH_PARLOOP(i) bihb.stg_base[i].flags.bits.parloop
#define BIH_PARSECT(i) bihb.stg_base[i].flags.bits.parsect
#define BIH_UJRES(i) bihb.stg_base[i].flags.bits.ujres
#define BIH_SIMD(i) bihb.stg_base[i].flags.bits.simd
#define BIH_LDVOL(i) bihb.stg_base[i].flags.bits.ldvol
#define BIH_STVOL(i) bihb.stg_base[i].flags.bits.stvol
#define BIH_ASM(i) bihb.stg_base[i].flags.bits.gasm

#define BIH_FLAGS2(i) bihb.stg_base[i].flags2.all
#define BIH_PARALN(i) bihb.stg_base[i].flags2.bits.paraln
#define BIH_INVIF(i) bihb.stg_base[i].flags2.bits.invif
#define BIH_NOINVIF(i) bihb.stg_base[i].flags2.bits.noinvif
#define BIH_COMBST(i) bihb.stg_base[i].flags2.bits.combst

#define BIH_DELETABLE(i) bihb.stg_base[i].flags2.bits.deletable

#define BIH_TASK(i) bihb.stg_base[i].flags2.bits.task
#define BIH_RESID(i) bihb.stg_base[i].flags2.bits.resid
#define BIH_VCAND(i) bihb.stg_base[i].flags2.bits.vcand
#define BIH_ACCEL(i) bihb.stg_base[i].flags2.bits.accel
#define BIH_ENDACCEL(i) bihb.stg_base[i].flags2.bits.endaccel
#define BIH_KERNEL(i) bihb.stg_base[i].flags2.bits.kernel
#define BIH_ENDKERNEL(i) bihb.stg_base[i].flags2.bits.endkernel
#define BIH_ACCDATA(i) bihb.stg_base[i].flags2.bits.accdata
#define BIH_ENDACCDATA(i) bihb.stg_base[i].flags2.bits.endaccdata
#define BIH_MIDIOM(i) bihb.stg_base[i].flags2.bits.midiom
#define BIH_RPCT(i) bihb.stg_base[i].flags2.bits.rpct
#define BIH_RPCT_CONFL(i) bihb.stg_base[i].flags2.bits.rpct_confl
#define BIH_RT_GUARDED(i) bihb.stg_base[i].flags2.bits.rt_guarded
#define BIH_DOCONC(i) bihb.stg_base[i].flags2.bits.doconc

#define BIH_ASSN(i) bihb.stg_base[i].assn
#define BIH_LPCNTFROM(i) bihb.stg_base[i].lpcntFrom
#define BIH_RGSET(i) bihb.stg_base[i].rgset
#define BIH_ILTFIRST(i) bihb.stg_base[i].first
#define BIH_ILTLAST(i) bihb.stg_base[i].last
#define BIH_PREV(i) bihb.stg_base[i].prev
#define BIH_NEXT(i) bihb.stg_base[i].next
#define BIH_FINDEX(i) bihb.stg_base[i].findex
#define BIH_FTAG(i) bihb.stg_base[i].ftag
#define BIH_BLKCNT(i) bihb.stg_base[i].blkCnt
#define BIH_AVLPCNT(i) bihb.stg_base[i].aveLpCnt

#define EXEC_COUNT double
#define UNKNOWN_EXEC_CNT -1.0

/***** External Data Declarations *****/

extern BIHB bihb;

#include "bihutil.h"

#endif /* BIH_H_ */
