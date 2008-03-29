# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils python

SLOT="0"
LICENSE="BSD"
KEYWORDS="~x86 ~amd64"
DESCRIPTION="The CE algorithm is a fast and accurate protein structure alignment algorithm."
SRC_URI="http://www.pymolwiki.org/images/0/03/Cealign-0.9.zip"
HOMEPAGE="http://www.pymolwiki.org/index.php/Cealign"
IUSE=""
RESTRICT="mirror"
DEPEND="dev-python/numpy
		>=dev-lang/python-2.4"
RDEPEND="${DEPEND}"

src_compile(){
	cd cealign-0.9
	python setup.py build
}

src_install(){
	python_version
	mtype=`uname -m`
	cd cealign-0.9
	exeinto /usr/lib/python${PYVER}/site-packages/
	if use amd64 ; then
		doexe build/lib.linux-${mtype}-${PYVER}/ccealign.so
	elif use x86 ; then
		doexe build/lib.linux-${mtype}-${PYVER}/ccealign.so
	fi
	insinto /usr/lib/python${PYVER}/site-packages/cealign
	doins qkabsch.py cealign.py
	dodoc PYMOLRC CHANGES doc/cealign.pdf
}

pkg_postinst(){
		einfo "remember to add"
		einfo "run /usr/lib/python${PYVER}/site-packages/cealign/qkabsch.py"
		einfo "run /usr/lib/python${PYVER}/site-packages/cealign/cealign.py"
		einfo "to your ~/.pymolrc file"
}