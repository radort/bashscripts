# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit git-r3 gnome2-live

DESCRIPTION=""
HOMEPAGE="https://git.gnome.org/browse/libnotifymm/"
EGIT_REPO_URI="https://git.gnome.org/browse/libnotifymm"

LICENSE="GPL-2"
SLOT="1.0/4" # pkgconfig/soname
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="
	dev-cpp/mm-common
"
RDEPEND="${DEPEND}"

AUTOTOOLS_AUTORECONF="yes"

src_prepare() {
	mm-common-prepare --copy --force
	gnome2-live_src_prepare
}

src_configure() {
	econf --enable-maintainer-mode
}
