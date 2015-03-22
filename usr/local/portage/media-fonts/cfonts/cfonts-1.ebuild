# Copyright 1999-2007 Gentoo Foundation 
# Distributed under the terms of the GNU General Public License v2 
# $Header: $ 

inherit font

DESCRIPTION="Microsoft's so-called C-fonts for Windows Vista and Office 2007"
HOMEPAGE="http://www.microsoft.com/downloads/details.aspx?familyid=048DC840-14E1-467D-8DCA-19D2A8FD7485&displaylang=en"
SRC_URI="http://download.microsoft.com/download/f/5/a/f5a3df76-d856-4a61-a6bd-722f52a5be26/PowerPointViewer.exe"
RESTRICT="mirror"

LICENSE="MSttfEULA"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE="X"

DEPEND="app-arch/cabextract"
RDEPEND=""

S=${WORKDIR}
FONT_S=${WORKDIR}
FONT_SUFFIX="ttf ttc"

src_unpack() { 
        cabextract ${DISTDIR}/${A} > /dev/null || die "failed to unpack ${A}" 
        cabextract --lowercase ppviewer.cab > /dev/null || die "failed to unpack ppviewer.cab" 
}
