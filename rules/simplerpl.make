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
PACKAGES-$(PTXCONF_SIMPLERPL) += simplerpl

#
# Paths and names
#
SIMPLERPL_VERSION	:= 1.0
SIMPLERPL_MD5		:= 9db49e83f4efc4e0aaf16f29d8f9c89d
SIMPLERPL		:= simpleRPL-$(SIMPLERPL_VERSION)
SIMPLERPL_SUFFIX	:= tar.gz
SIMPLERPL_URL		:= https://github.com/tcheneau/simpleRPL/archive/v1.0.$(SIMPLERPL_SUFFIX)
SIMPLERPL_SOURCE	:= $(SRCDIR)/v1.0.$(SIMPLERPL_SUFFIX)
SIMPLERPL_DIR		:= $(BUILDDIR)/$(SIMPLERPL)
SIMPLERPL_LICENSE	:= unknown

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

SIMPLERPL_CONF_TOOL	:= NO

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/simplerpl.compile:
	@$(call targetinfo)
	@cd $(SIMPLERPL_DIR) && \
		$(CROSS_ENV) $(CROSS_PYTHON) setup.py build -e "/usr/bin/env python"
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/simplerpl.install:
	@$(call targetinfo)
	@cd $(SIMPLERPL_DIR) && \
		$(CROSS_PYTHON) \
		setup.py install --root=$(SIMPLERPL_PKGDIR) --prefix="/usr"
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/simplerpl.targetinstall:
	@$(call targetinfo)

	@$(call install_init, simplerpl)
	@$(call install_fixup, simplerpl,PRIORITY,optional)
	@$(call install_fixup, simplerpl,SECTION,base)
	@$(call install_fixup, simplerpl,AUTHOR,"Alexander Aring <aar@pengutronix.de>")
	@$(call install_fixup, simplerpl,DESCRIPTION,missing)

	@for file in $(shell cd $(SIMPLERPL_PKGDIR) && find . -name "*.pyc"); \
		do \
		$(call install_copy, simplerpl, 0, 0, 0644, -, /$$file); \
	done

	@$(call install_copy, simplerpl, 0, 0, 0755, -, /usr/bin/cliRPL.py)
	@$(call install_copy, simplerpl, 0, 0, 0755, -, /usr/bin/simpleRPL.py)

	@$(call install_finish, simplerpl)

	@$(call touch)

# vim: syntax=make
