# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit python

SLOT="0"
LICENSE="BSD"
KEYWORDS="~x86 ~amd64"
DESCRIPTION="The CE algorithm is a fast and accurate protein structure alignment algorithm."
SRC_URI="http://www.pymolwiki.org/images/0/03/Cealign-0.9.zip"
HOMEPAGE="http://www.pymolwiki.org/index.php/Cealign"
IUSE=""
RESTRICT="mirror"
DEPEND="dev-python/numpy
		>=dev-lang/python-2.4
		>sci-chemistry/pymol-0.99"
RDEPEND="${DEPEND}"

S="cealign-0.9"

src_compile(){
	cd "${S}"
	python setup.py build
}

src_install(){
	python_version
	mtype=`uname -m`

	cd "${S}"
	exeinto /usr/$(get_libdir)/python${PYVER}/site-packages/
	if use amd64 ; then
		doexe build/lib.linux-${mtype}-${PYVER}/ccealign.so
	elif use x86 ; then
		doexe build/lib.linux-${mtype}-${PYVER}/ccealign.so
	fi
	insinto /usr/$(get_libdir)/python${PYVER}/site-packages/cealign
	doins qkabsch.py cealign.py

	cat >> "${T}"/pymolrc <<- EOF
	run /usr/$(get_libdir)/python${PYVER}/site-packages/cealign/qkabsch.py
	run /usr/$(get_libdir)/python${PYVER}/site-packages/cealign/cealign.py
	EOF

	insinto ${PYMOL_PATH}
	doins "${T}"/pymolrc

	dodoc PYMOLRC CHANGES doc/cealign.pdf
}

pkg_postrm() {
	python_mod_cleanup "${ROOT}"/usr/$(get_libdir)/python${PYVER}/site-packages/pmg_tk/startup/
}