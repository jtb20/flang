#
# Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
#
# F2008 Compliance Tests: Flang-F2008-Impure elemental procedures
#
# Date of Modification: Fri Oct 18
#

########## Make rule for test impure01  ########


impure01: impure01.run

impure01.$(OBJX):  $(SRC)/impure01.f08
	-$(RM) impure01.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/impure01.f08 -o impure01.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) impure01.$(OBJX) check.$(OBJX) $(LIBS) -o impure01.$(EXESUFFIX)


impure01.run: impure01.$(OBJX)
	@echo ------------------------------------ executing test impure01
	impure01.$(EXESUFFIX)

build:	impure01.$(OBJX)

verify:	;

run:	 impure01.$(OBJX)
	@echo ------------------------------------ executing test impure01
	-impure01.$(EXESUFFIX) ||:
