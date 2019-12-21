#
# Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
# See https://llvm.org/LICENSE.txt for license information.
# SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
#

########## Make rule for test il05  ########


il05: run
	

build:  $(SRC)/il05.f90
	-$(RM) il05.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/il05.f90 -o il05.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) il05.$(OBJX) check.$(OBJX) $(LIBS) -o il05.$(EXESUFFIX)


run:
	@echo ------------------------------------ executing test il05
	il05.$(EXESUFFIX)

verify: ;

il05.run: run

