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
PACKAGES-$(PTXCONF_PYTHON_LIBNL_ROUTING) += python-libnl-routing

#
# Paths and names
#
PYTHON_LIBNL_ROUTING_VERSION	:= 0.1
PYTHON_LIBNL_ROUTING_MD5	:= e5dc240d004420db27081cfce346cc7a
PYTHON_LIBNL_ROUTING		:= python-libnl-routing-$(PYTHON_LIBNL_ROUTING_VERSION)
PYTHON_LIBNL_ROUTING_SUFFIX	:= zip
PYTHON_LIBNL_ROUTING_SOURCE	:= $(SRCDIR)/master.$(PYTHON_LIBNL_ROUTING_SUFFIX)
PYTHON_LIBNL_ROUTING_DIR	:= $(BUILDDIR)/Routing-master
PYTHON_LIBNL_ROUTING_LICENSE	:= unknown

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

PYTHON_LIBNL_ROUTING_CONF_TOOL	:= NO

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/python-libnl-routing.compile:
	@$(call targetinfo)
	@cd $(PYTHON_LIBNL_ROUTING_DIR) && \
		$(CROSS_ENV) $(CROSS_PYTHON) \
		$(PYTHON_LIBNL_ROUTING_DIR)/setup.py build_ext
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/python-libnl-routing.install:
	@$(call targetinfo)
	@cd $(PYTHON_LIBNL_ROUTING_DIR) && \
		$(CROSS_ENV) $(CROSS_PYTHON) \
		$(PYTHON_LIBNL_ROUTING_DIR)/setup.py install --root=$(PYTHON_LIBNL_ROUTING_PKGDIR) --prefix="/usr"
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/python-libnl-routing.targetinstall:
	@$(call targetinfo)

	@$(call install_init, python-libnl-routing)
	@$(call install_fixup, python-libnl-routing,PRIORITY,optional)
	@$(call install_fixup, python-libnl-routing,SECTION,base)
	@$(call install_fixup, python-libnl-routing,AUTHOR,"Alexander Aring <aar@pengutronix.de>")
	@$(call install_fixup, python-libnl-routing,DESCRIPTION,missing)

	@$(call install_copy, python-libnl-routing, 0, 0, 0755, -, $(PYTHON_SITEPACKAGES)/Routing.so)

	@$(call install_finish, python-libnl-routing)

	@$(call touch)

# vim: syntax=make
