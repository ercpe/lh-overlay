# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="A cross-platform graphical viewer for chromatogram files."
HOMEPAGE="http://www.geospiza.com/finchtv/"

MY_PV="${PV//./_}"
MY_P=${PN}_${MY_PV}

#SRC_URI="http://www.geospiza.com/finchtv/download/programs/linux/${MY_P}.tar.gz"

S="${WORKDIR}/${MY_P}"

LICENSE="finchtv"
SLOT="0"
#KEYWORDS="~amd64 ~x86"
KEYWORDS="-*"
IUSE=""

DEPEND=""
RDEPEND=""

src_compile() {
	echo
	einfo "Nothing to compile."
	echo
}

src_install() {

	cd "${S}"
	exeinto /opt/bin
	doexe finchtv || die "Failed to install executable"
	dodoc License.txt ReleaseNotes.txt \
		|| die "Failed to install docs"
	dohtml -r Help/* \
		|| die "Failed to install html docs"
	mv SampleData "${D}"/usr/share/doc/${PF}/ \
		|| die "Failed to move SampleData"

}
