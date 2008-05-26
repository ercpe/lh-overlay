# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit python

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64"
DESCRIPTION="DivScore is intended to be used with AMBER and DivCon for preprocessing biological structures"
SRC_URI="http://shoichetlab.compbio.ucsf.edu/~raha/research/ramm.tar.gz"
HOMEPAGE="http://shoichetlab.compbio.ucsf.edu/~raha/research/divscore.html"
IUSE=""
RESTRICT="mirror"
RDEPEND="sys-apps/util-linux
		 sci-chemistry/openbabel
		 >sci-chemistry/pymol-0.99"
DEPEND=""

src_install(){
	python_version
	insinto /usr/$(get_libdir)/python${PYVER}/site-packages/pmg_tk/startup/
	doins -r "${WORKDIR}"/ramm/ "${WORKDIR}"/ramm.py
}

pkg_postinst(){
	python_mod_optimize "${ROOT}"/usr/$(get_libdir)/python${PYVER}/site-packages/pmg_tk/startup/
}

pkg_postrm() {
	python_mod_cleanup "${ROOT}"/usr/$(get_libdir)/python${PYVER}/site-packages/pmg_tk/startup/
}