# -*-makefile-*-
#
# Copyright (C) 2014 by Alexander Aring <aar@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_CYTHON) += host-cython

#
# Paths and names
#
HOST_CYTHON_VERSION	:= 0.19.2
HOST_CYTHON_MD5		:= 4af1218346510b464c0a6bf15500d0e2
HOST_CYTHON		:= Cython-$(HOST_CYTHON_VERSION)
HOST_CYTHON_SUFFIX	:= tar.gz
HOST_CYTHON_URL		:= http://cython.org/release/$(HOST_CYTHON).$(HOST_CYTHON_SUFFIX)
HOST_CYTHON_SOURCE	:= $(SRCDIR)/$(HOST_CYTHON).$(HOST_CYTHON_SUFFIX)
HOST_CYTHON_DIR		:= $(HOST_BUILDDIR)/$(HOST_CYTHON)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_CYTHON_PATH        := PATH=$(HOST_PATH)
HOST_CYTHON_CONF_TOOL	:= NO

$(STATEDIR)/host-cython.compile:
	@$(call targetinfo)
	@cd $(HOST_CYTHON_DIR) && \
		python2 setup.py build
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/host-cython.install:
	@$(call targetinfo)
	@cd $(HOST_CYTHON_DIR) && \
		python2 setup.py install --root=$(PTXCONF_SYSROOT_TARGET) --prefix="/usr"
	@$(call touch)

# vim: syntax=make
