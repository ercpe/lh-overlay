# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

# inherit

DESCRIPTION="Extracts several archive types with one command"
HOMEPAGE="http://linuxtidbits.wordpress.com/2009/08/04/week-of-bash-scripts-extract/"
SRC_URI="http://gentoo.j-schmitz.net/portage-overlay/app-arch/extract/${P}.tar.bz2"

LICENSE="as-is"

SLOT="0"
KEYWORDS=""

RESTRICT="mirror"

IUSE=""
RDEPEND="app-arch/p7zip app-arch/unzip app-arch/gzip"
DEPEND="${RDEPEND}"


pkg_setup() {
	exeinto /bin/
	doexe extract.sh
}
