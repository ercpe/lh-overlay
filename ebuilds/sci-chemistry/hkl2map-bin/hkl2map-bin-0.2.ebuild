# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

DESCRIPTION="HKL2MAP is a graphical user-interface for macromolecular phasing."
HOMEPAGE="http://schneider.group.ifom-ieo-campus.it/hkl2map/index.html"
SRC_URI="
	hkl2map-0.2.tgz
	http://schneider.group.ifom-ieo-campus.it/hkl2map/phs2mtz"

RESTRICT="fetch"
LICENSE="as-is"
SLOT="0"
KEYWORDS="-* ~x86"
IUSE=""

RDEPEND="
	sci-chemistry/shelx
	>=dev-lang/tk-8.3
	sci-chemistry/ccp4"
DEPEND=""

pkg_nofetch(){
	einfo "Please visit:"
	einfo "\thttp://schneider.group.ifom-ieo-campus.it/hkl2map/index.html"
	einfo
	einfo "Complete the registration process, then download the following files:"
	einfo "\t${A}"
	einfo
	einfo "Place the downloaded files in your distfiles directory:"
	einfo "\t${DISTDIR}"
}

src_unpack(){
	unpack ${P}.tgz
	if use script;then
		cp "${DISTDIR}"/phs2mtz "${WORKDIR}"
	fi
}

src_install() {
	newbin hkl2map-0.2-dist hkl2map || die
	dobin "${WORKDIR}"/phs2mtz || die
}

pkg_postinst(){
	echo
	einfo "If you use HKL2MAP in you work, please cite the following publication:"
	echo
	einfo "Thomas Pape & Thomas R. Schneider"
	einfo "HKL2MAP: a graphical user interface for phasing with SHELX programs"
	einfo "J. Appl. Cryst. 37:843-844 (2004)."
	echo
}
