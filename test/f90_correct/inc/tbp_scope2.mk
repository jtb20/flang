
# Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
# See https://llvm.org/LICENSE.txt for license information.
# SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception

#
# Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
#

########## Make rule for test tbp_scope2  ########


tbp_scope2: run

build:  $(SRC)/tbp_scope2.f90
	-$(RM) tbp_scope2.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/tbp_scope2.f90 -o tbp_scope2.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) tbp_scope2.$(OBJX) check.$(OBJX) $(LIBS) -o tbp_scope2.$(EXESUFFIX)


run:
	@echo ------------------------------------ executing test tbp_scope2
	tbp_scope2.$(EXESUFFIX)

verify: ;

