/*
 * Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
 * See https://llvm.org/LICENSE.txt for license information.
 * SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
 *
 */
/*
 * Copyright (c) 2018, Advanced Micro Devices, Inc. All rights reserved.
 *
 *file casinh.c 
 *
 * Support for complex datatype argumentts
 * Date of Modification: 08 January 2020
 *
 */
#pragma global - Mx, 6, 0x100

#include "mthdecls.h"

CMPLXFUNC_C(__mth_i_casinh)
{
  CMPLXARGS_C;
  float_complex_t f;
  f = casinhf(carg);
  CRETURN_C(f);
}
