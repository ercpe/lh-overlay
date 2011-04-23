# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

DESCRIPTION="Extracts several archive types with one command"
HOMEPAGE="http://linuxtidbits.wordpress.com/2009/08/04/week-of-bash-scripts-extract/ http://j-schmitz.net/"
SRC_URI="http://gentoo.j-schmitz.net/portage-overlay/${CATEGORY}/${PN}/${P}.tar.bz2"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE=""

RESTRICT="mirror"

RDEPEND="
	app-arch/p7zip[rar]
	app-arch/unzip
	app-arch/gzip"
DEPEND=""

S="${WORKDIR}"

src_install(){
	newbin extract.sh extract || die
}
