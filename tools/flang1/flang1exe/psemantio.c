/*
 * Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
 * See https://llvm.org/LICENSE.txt for license information.
 * SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
 *
 */

/** \file
    \brief Empty semantic analyzer routines which process IO statements.
 */

#include "gbldefs.h"
#include "global.h"
#include "gramsm.h"
#include "gramtk.h"
#include "symtab.h"
#include "semant.h"
#include "scan.h"
#include "dinit.h"
#include "semstk.h"
#include "ast.h"
#include "feddesc.h"

/**
    \param rednum reduction number
    \param top    top of stack after reduction
 */
void
psemantio(int rednum, SST *top)
{
  SST_ASTP(LHS, 0);
}
