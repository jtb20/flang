/*
 * Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
 * See https://llvm.org/LICENSE.txt for license information.
 * SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
 *
 */
/*
 * Modifications Copyright (c) 2019 Advanced Micro Devices, Inc. All rights reserved.
 * Notified per clause 4(b) of the license.
 */

/* inhibit floating point copy propagation */
#pragma global - Mx, 6, 0x100

#include "mthdecls.h"

__float128 __attribute__((weak)) hypotq(__float128 x, __float128 y);

__float128
__mth_i_qhypot(__float128 x, __float128 y)
{
  __float128 f = hypotq(x, y);
  return f;
}
