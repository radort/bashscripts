# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit git-r3 cmake-utils

DESCRIPTION="gTox"
HOMEPAGE="https://github.com/KoKuToru/gTox"
EGIT_REPO_URI="https://github.com/KoKuToru/gTox.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

S="${WORKDIR}/${P}/Source"

DEPEND="
	dev-cpp/gtkmm:3.0=
	media-libs/libcanberra
	dev-cpp/gstreamermm:1.0=
	dev-cpp/libnotifymm:1.0=
"
RDEPEND="${DEPEND}"
