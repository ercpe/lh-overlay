# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils python

MY_P="${PN}${PV}"
SLOT="0"
LICENSE="cns"
KEYWORDS="~amd64 ~x86"
DESCRIPTION="ARIA is a software for automated NOE assignment and NMR structure calculation."
SRC_URI="http://aria.pasteur.fr/archives/${MY_P}.tar.gz"
HOMEPAGE="http://aria.pasteur.fr/"
IUSE="examples"
RESTRICT="fetch"
DEPEND="sci-chemistry/cns
		dev-lang/python
		|| ( dev-python/numeric dev-python/numpy )
		>=dev-python/scientificpython-2.7.3
		>=dev-lang/tk-8.3
		>=dev-tcltk/tix-8.1.4
		>=sci-chemistry/ccpnmr-1.0.15-r1
		dev-python/matplotlib"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

pkg_nofetch(){
	einfo "Go to ${HOMEPAGE}, download ${A}"
	einfo "and place it in ${DISTDIR}"
}

pkg_setup(){
	python_version
	
	if ( ! built_with_use dev-lang/python tk || ! built_with_use dev-python/matplotlib tk ); then
		ewarn "dev-lang/python and dev-python/matplotlib need to be build with tk"
		die "NO tk support in either dev-lang/python or dev-python/matplotlib"
	fi
	if ( ! built_with_use sci-chemistry/cns aria ); then
		ewarn "sci-chemistry/cns has to be emerged with USE aria"
		die "NO aria support in sci-chemistry/cns"
	fi
}

src_unpack(){
	unpack "${A}"
	epatch "${FILESDIR}"/sa_ls_cool2.patch
}

src_test(){
	${python} check.py || die 
}

src_install(){
	insinto /usr/$(get_libdir)/python$PYVER/site-packages/aria
	doins -r src aria2.py
	insinto /usr/$(get_libdir)/python$PYVER/site-packages/aria/cns
	doins -r cns/{protocols,toppar,src/helplib}
	
	if use examples; then
		insinto /usr/share/${P}/
		doins -r examples
	fi 

# ENV
	cat >> "${T}"/20aria <<- EOF
	ARIA2="/usr/$(get_libdir)/python$PYVER/site-packages/aria"
	EOF
	
	doenvd "${T}"/20aria

# Launch Wrapper
	cat >> "${T}"/aria <<- EOF
	#!/bin/sh
	exec "${python}" -O "${ARIA2}"/aria2.py \$*
	EOF

	dobin  "${T}"/aria

	dodoc COPYRIGHT README
}
