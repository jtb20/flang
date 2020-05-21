/*
 * Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
 * See https://llvm.org/LICENSE.txt for license information.
 * SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
 *
 * Modifications Copyright (c) 2019 Advanced Micro Devices, Inc. All rights reserved.
 * Notified per clause 4(b) of the license.
 *
 * Last Modified: June 2020
 *
 */

#include "mthdecls.h"

QMPLXFUNC_C_I(__mth_i_cqpowi)
{
  QMPLXARGS_C_I;
  int k;
  __float128 fr, fi, gr, gi, tr, ti;
  static const quad_complex_t c1plusi0 = PGMATH_CMPLX_CONST(1.0, 0.0);

  fr = 1;
  fi = 0;
  k = i;
  gr = real;
  gi = imag;
  if (k < 0)
    k = -k;
  while (k) {
    if (k & 1) {
      tr = fr * gr - fi * gi;
      ti = fr * gi + fi * gr;
      fr = tr;
      fi = ti;
    }
    k = (unsigned)k >> 1;
    tr = gr * gr - gi * gi;
    ti = 2.0 * gr * gi;
    gr = tr;
    gi = ti;
  }

  quad_complex_t q = pgmath_cmplx(fr, fi);
  if (i < 0) {
    QMPLX_CALL_QR_Q_Q(__mth_i_cqdiv,q,c1plusi0,q);
  }
  QRETURN_C(q);

}
