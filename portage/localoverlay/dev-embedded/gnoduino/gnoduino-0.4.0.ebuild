# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
PYTHON_COMPAT=( python2_6 python2_7 )

inherit python gnome2-utils distutils

DESCRIPTION="GNOME Arduino Electronics Prototyping Environment"
HOMEPAGE="http://gnome.eu.org/evo/index.php/Gnoduino"
#SRC_URI="http://gnome.eu.org/gnoduino-0.3.0.tar.gz"
SRC_URI="http://gnome.eu.org/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
#KEYWORDS="amd64 x86"
KEYWORDS="~amd64"

IUSE=""

DEPEND="dev-python/pyserial
	dev-python/pygtksourceview
	dev-python/pygobject
	dev-python/pygtk
	dev-python/gconf-python
	dev-python/gnome-vfs-python"

S=${WORKDIR}/${P}

src_prepare() {
	python_convert_shebangs -r 2 .
}

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_install(){
	export GCONF_DISABLE_MAKEFILE_SCHEMA_INSTALL="1"
	distutils_src_install
	unset GCONF_DISABLE_MAKEFILE_SCHEMA_INSTALL
}

pkg_postrm() {
        gnome2_gconf_uninstall
}

pkg_preinst() {
	gnome2_gconf_savelist
}

pkg_postinst() {
	gnome2_gconf_install

	ewarn "To be able to fully use Gnoduino you need to aquire the avr toolchain,"
	ewarn "i.e.: "
	ewarn "   USE="-openmp" crossdev -t avr -s4 -S --without-headers "
	ewarn " and set the kernel options: "
	ewarn "   Device Drivers -> USB support -> USB Serial Converter support -> USB FTDI Single Port Serial Driver "
	ewarn "   Device Drivers -> USB support -> USB Modem \(CDC ACM\) support "
	ewarn " "
	ewarn " Some resources:"
	ewarn "   http://playground.arduino.cc/linux/gentoo "
	ewarn "   https://bugs.gentoo.org/show_bug.cgi?id=147155 "
        ewarn "   http://forums.gentoo.org/viewtopic-t-907860.html "
        ewarn " "
	elog
}
