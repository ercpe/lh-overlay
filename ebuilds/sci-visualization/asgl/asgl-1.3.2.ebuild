# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

inherit eutils multilib toolchain-funcs

DESCRIPTION="Program for preparing all sorts of PostScript plots from simple data files."
HOMEPAGE="http://salilab.org/asgl"
SRC_URI="ftp://salilab.org/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE=""
SLOT="0"

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
		ASGLINSTALL="${D}/usr/$(get_libdir)/libasgl" \
		opt || die
}

src_install(){
	emake -j1 \
		ASGLINSTALL="${D}/usr/$(get_libdir)/libasgl" \
		install || die
	dosym /usr/lib/libasgl/asgl /usr/bin/
	dosym /usr/lib/libasgl/asgl_gfortran /usr/bin/
	dosym /usr/lib/libasgl/setasgl /usr/bin/
#	emake -j1 installman

	insinto /usr/share/${PN}/examples/
	doins -r examples/{*dat,*top}
	dodoc {README,ChangeLog}
}
