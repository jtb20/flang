#
# Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
#
# F2008 Compliance Tests: Stop code - Execution control
#
# Date of Modification: Sep 10 2019
#
########## Make rule for test bitint10  ########

bitint10: bitint10.run

#include ./passok.mk

passok.$(OBJX):  $(SRC)/passok.f08
	-$(RM) passok.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/passok.f08 -o passok.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) passok.$(OBJX) check.$(OBJX) $(LIBS) -o passok.$(EXESUFFIX)

bitint10.$(OBJX):  $(SRC)/bitint10.f08
	-$(RM) bitint10.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	#-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/bitint10.f08 -o bitint10.$(OBJX) ||:
	#-$(FC) $(FFLAGS) $(LDFLAGS) bitint10.$(OBJX) check.$(OBJX) $(LIBS) -o bitint10.$(EXESUFFIX) ||:

bitint10.run: passok.$(OBJX)
	@echo ------------------------------------ executing test bitint10
	-passok.$(EXESUFFIX) ||:

build:	bitint10.$(OBJX)

verify:	;

run:	 passok.$(OBJX)
	@echo ------------------------------------ executing test bitint10
	-passok.$(EXESUFFIX) ||:
