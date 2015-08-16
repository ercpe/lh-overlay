# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit eutils multilib toolchain-funcs

DESCRIPTION="Program for preparing all sorts of PostScript plots from simple data files"
HOMEPAGE="http://salilab.org/asgl"
SRC_URI="ftp://salilab.org/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

src_prepare(){
	epatch \
		"${FILESDIR}/exec_bits.patch" \
		"${FILESDIR}/${PV}-gentoo.patch"
	sed '/strip/d' -i scripts/Makefile.include1 || die
}

get_fcomp() {
	case $(tc-getFC) in
	*gfortran* )
	FCOMP="gfortran" ;;
	ifort )
	FCOMP="ifc" ;;
	* )
	FCOMP=$(tc-getFC) ;;
	esac
}

src_compile(){
	get_fcomp
	emake -j1 \
		ASGL_EXECUTABLE_TYPE=${FCOMP} \
		ASGLINSTALL="${ED}/usr/$(get_libdir)/libasgl" \
		opt
}

src_install(){
	emake -j1 \
		ASGLINSTALL="${ED}/usr/$(get_libdir)/libasgl" \
		install
	dosym /usr/lib/libasgl/asgl /usr/bin/
	dosym /usr/lib/libasgl/asgl_gfortran /usr/bin/
	dosym /usr/lib/libasgl/setasgl /usr/bin/

	insinto /usr/share/${PN}/examples/
	doins -r examples/{*dat,*top}
	dodoc README ChangeLog
}
