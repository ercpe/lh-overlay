# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

DESCRIPTION="Strips comments an lines with whitespaces from files"
HOMEPAGE="http://linuxtidbits.wordpress.com/2009/08/07/week-of-bash-scripts-rps-and-commentstrip/"
SRC_URI="http://gentoo.j-schmitz.net/portage-overlay/${CATEGORY}/${PN}/${P}.tar.bz2"

LICENSE="as-is"

SLOT="0"
KEYWORDS="x86 amd64"

RESTRICT="mirror"

IUSE="X"
RDEPEND="X? ( x11-misc/xclip )"
DEPEND="${RDEPEND}"

S="${WORKDIR}"/stripcomments-1.0

src_install(){
	exeinto /usr/lib/stripcomments
	doexe stripcomments.sh

	dosym /usr/lib/stripcomments/stripcomments.sh /bin/stripcomments	
}
