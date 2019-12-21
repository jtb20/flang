! Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
! See https://llvm.org/LICENSE.txt for license information.
! SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
!

module mod
logical expect(10), rslt(10)
type :: stuff(l1)
integer,len :: l1 = 10
end type
type,extends(stuff) :: objects(k1,k2)
integer, kind :: k2 = selected_char_kind("ASCII")
integer, kind :: k1 = selected_int_kind(4)
integer(k1) :: p(l1)
character(len=l1*2) :: c
end type
contains
subroutine foo(n)
integer n
type(objects(l1=10)) :: x
rslt(5) = x%k1 .eq. selected_int_kind(4) 
rslt(6) = x%k2 .eq. selected_char_kind("ASCII") 
rslt(7) = x%l1 .eq. n 
rslt(8) = size(x%p) .eq. x%l1

do i=1,n
x%p(i) = i
enddo

rslt(9) = .true.
do i=1,n
if (x%p(i) .ne. i) rslt(9) = .false.
enddo

x%c = '12345678901234567890'
rslt(10) = x%c .eq. '12345678901234567890'

end subroutine

end module

program p
use mod
integer y 
type(objects(30,1,20)) :: x

rslt(1) = x%k1 .eq. 1
rslt(2) = x%k2 .eq. 20
rslt(3) = x%l1 .eq. 30
rslt(4) = size(x%p) .eq. x%l1

call foo(10)

expect = .true.
call check(rslt,expect,10)



end
