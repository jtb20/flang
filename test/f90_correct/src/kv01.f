** Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
** See https://llvm.org/LICENSE.txt for license information.
** SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception

* Vectorizer - decremented induction variables and streaming
*              iscbugs 911004g.f & 911004h.f

	program p
	parameter (N=4)

	real result(N)
	real expect(N)

	dimension c(N)
	common pad1(100), c, pad2(100)
	data result /N*0.0/
	data c /N*1.0/
	data expect / N*4.0/

	call svpoly(N, result, c, 1, n+1, 1.0)
	call check(result, expect, N)
	end

	subroutine svpoly(m, z, c, incc, iic, s)
	dimension z(1), c(1)
	do iz = 1, m
	    ic = iic
	    do j = m, 1, -1
		ic = ic - incc
		z(iz) = s*z(iz) + c(ic)
	    enddo
	enddo
	end
