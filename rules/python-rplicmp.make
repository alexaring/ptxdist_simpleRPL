# -*-makefile-*-
#
# Copyright (C) 2013 by Alexander Aring <aar@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_PYTHON_RPLICMP) += python-rplicmp

#
# Paths and names
#
PYTHON_RPLICMP_VERSION	:= 1.0
PYTHON_RPLICMP_MD5	:= 7b8e4af24aa9fc5c42cfbfc49c262a98
PYTHON_RPLICMP		:= python-rplicmp-$(PYTHON_RPLICMP_VERSION)
PYTHON_RPLICMP_SUFFIX	:= zip
PYTHON_RPLICMP_URL	:= https://github.com/tcheneau/RplIcmp/archive/v1.0.$(PYTHON_RPLICMP_SUFFIX)
PYTHON_RPLICMP_SOURCE	:= $(SRCDIR)/v1.0.$(PYTHON_RPLICMP_SUFFIX)
PYTHON_RPLICMP_DIR	:= $(BUILDDIR)/RplIcmp-1.0
PYTHON_RPLICMP_LICENSE	:= unknown

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

PYTHON_RPLICMP_CONF_TOOL	:= NO

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/python-rplicmp.compile:
	@$(call targetinfo)
	@cd $(PYTHON_RPLICMP_DIR) && \
		$(CROSS_ENV) $(CROSS_CC) -Wall -pedantic -lcap -c -fPIC -o caplib.o caplib.c && \
		$(CROSS_ENV) $(CROSS_CC) -Wall -pedantic -lcap -c -fPIC -o icmplib.o icmplib.c && \
		$(CROSS_ENV) $(CROSS_PYTHON) setup.py build_ext
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/python-rplicmp.install:
	@$(call targetinfo)
	@cd $(PYTHON_RPLICMP_DIR) && \
		$(CROSS_ENV) $(CROSS_PYTHON) \
		setup.py install --root=$(PYTHON_RPLICMP_PKGDIR) --prefix="/usr"
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/python-rplicmp.targetinstall:
	@$(call targetinfo)

	@$(call install_init, python-rplicmp)
	@$(call install_fixup, python-rplicmp,PRIORITY,optional)
	@$(call install_fixup, python-rplicmp,SECTION,base)
	@$(call install_fixup, python-rplicmp,AUTHOR,"Alexander Aring <aar@pengutronix.de>")
	@$(call install_fixup, python-rplicmp,DESCRIPTION,missing)

	@$(call install_copy, python-rplicmp, 0, 0, 0755, -, $(PYTHON_SITEPACKAGES)/RplIcmp.so)

	@$(call install_finish, python-rplicmp)

	@$(call touch)

# vim: syntax=make
