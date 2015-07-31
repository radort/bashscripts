# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit git-r3 autotools-utils

DESCRIPTION="IP over DNS tunnel"
HOMEPAGE="https://git.gnome.org/browse/network-manager-iodine"
EGIT_REPO_URI="git://git.gnome.org/network-manager-iodine"

CONFIG_CHECK="~TUN"
IUSE="static-libs"

LICENSE="GPL-2" #GPL-2 for init script bug #426060
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="sys-libs/zlib"
DEPEND="${RDEPEND}"

AUTOTOOLS_AUTORECONF=yes

PATCHES=(
	"${FILESDIR}"/fix-out-of-tree.patch
)
src_configure() {
	local myeconfargs=(
		--disable-more-warnings
	)
	autotools-utils_src_configure
}
