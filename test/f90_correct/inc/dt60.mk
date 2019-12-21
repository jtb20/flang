#
# Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
# See https://llvm.org/LICENSE.txt for license information.
# SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
#

########## Make rule for test dt60  ########


dt60: run
	

build:  $(SRC)/dt60.f90
	-$(RM) dt60.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/dt60.f90 -o dt60.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) dt60.$(OBJX) check.$(OBJX) $(LIBS) -o dt60.$(EXESUFFIX)


run:
	@echo ------------------------------------ executing test dt60
	dt60.$(EXESUFFIX)

verify: ;

