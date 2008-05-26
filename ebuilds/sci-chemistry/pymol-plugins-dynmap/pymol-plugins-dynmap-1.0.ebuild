# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit python

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64"
DESCRIPTION="DYN-MAP generates maps of functional groups in a protein and visualize them using dynamic parameters"
SRC_URI="http://www.giacomobastianelli.com/Files/DYNMAP_v${PV}.tar.gz"
HOMEPAGE="http://www.giacomobastianelli.com/work.html"
IUSE=""
RESTRICT="mirror"
RDEPEND=">=sci-biology/biopython-1.43
		>=dev-python/cheetah-2.0
		>=sci-chemistry/gromacs-3.3.1
		sci-chemistry/msms-bin"
DEPEND=""

src_unpack(){
	python_version
	unpack DYNMAP_v${PV}.tar.gz
	if [[ "${PYVER}" == "2.5" ]] ; then
		epatch "${FILESDIR}"/dynmap-${PV}-python2.5.patch || die "epatch dynmap-python2.5.patch failed"
	else
		epatch "${FILESDIR}"/dynmap-${PV}.patch || die "epatch dynmap-${PV}.patch failed"
	fi
}

src_install(){
	insinto /usr/lib/dynmap/
	doins -r DYNMAP_v${PV}/*{py,gif}
	dosym /usr/lib/dynmap/DYN-MAP /usr/bin/DYN-MAP
	dodoc DYNMAP_v${PV}/README.txt
}

pkg_postinst(){
	python_mod_optimize "${ROOT}"/usr/$(get_libdir)/python${PYVER}/site-packages/pmg_tk/startup/
}

pkg_postrm() {
	python_mod_cleanup "${ROOT}"/usr/$(get_libdir)/python${PYVER}/site-packages/pmg_tk/startup/
}