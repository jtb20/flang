#
# Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
# See https://llvm.org/LICENSE.txt for license information.
# SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
#

########## Make rule for test acl01  ########


acl01: run
	

build:  $(SRC)/acl01.f90
	-$(RM) acl01.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC)  -c $(FFLAGS) $(LDFLAGS) $(SRC)/acl01.f90 -o acl01.$(OBJX)
	-$(FC)  $(FFLAGS) $(LDFLAGS) acl01.$(OBJX) check.$(OBJX) $(LIBS) -o acl01.$(EXESUFFIX)


run: 
	@echo ------------------------------------ executing test acl01
	acl01.$(EXESUFFIX)

verify: ;

