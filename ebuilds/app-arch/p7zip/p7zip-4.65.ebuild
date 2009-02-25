# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
WX_GTK_VER="2.8"

inherit eutils toolchain-funcs multilib wxwidgets

DESCRIPTION="Port of 7-Zip archiver for Unix"
HOMEPAGE="http://p7zip.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${PN}_${PV}_src_all.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="wxwindows doc kde static"

RDEPEND="wxwindows? ( x11-libs/wxGTK[X] )"
DEPEND="${RDEPEND}"

S=${WORKDIR}/${PN}_${PV}

src_prepare() {
	sed -i \
		-e "/^CXX=/s:g++:$(tc-getCXX):" \
		-e "/^CC=/s:gcc:$(tc-getCC):" \
		-e "s:OPTFLAGS=-O:OPTFLAGS=${CXXFLAGS}:" \
		-e 's:-s ::' \
		-e '/Rar/d' \
		makefile* || die "changing makefiles"

	if use amd64; then
		cp -f makefile.linux_amd64 makefile.machine
	elif [[ ${CHOST} == *-darwin* ]] ; then
		# Mac OS X needs this special makefile, because it has a non-GNU linker
		cp -f makefile.macosx makefile.machine
	elif use x86-fbsd; then
		# FreeBSD needs this special makefile, because it hasn't -ldl
		sed -e 's/-lc_r/-pthread/' makefile.freebsd > makefile.machine
	fi
	use static && sed -i -e '/^LOCAL_LIBS=/s/LOCAL_LIBS=/&-static /' makefile.machine

	# patching to not included nonfree RAR decompression code is higher a sed call
	# But we're removing nonfree code just in case sed wasnt enough
	rm -rf CPP/7zip/Compress/Rar

	epatch "${FILESDIR}"/${PV}-makefile.patch
}

src_compile() {
	emake all3 || die "compilation error"
	if use wxwindows; then
		emake 7zG || die "error building GUI"
	fi
}

src_test() {
	emake test_7z test_7zr || die "test failed"
	if use wxwindows; then
		emake test_7zG || die "GUI test failed"
	fi
}

src_install() {
	# this wrappers can not be symlinks, p7zip should be called with full path
	make_wrapper 7zr "/usr/lib/${PN}/7zr"
	make_wrapper 7za "/usr/lib/${PN}/7za"
	make_wrapper 7z "/usr/lib/${PN}/7z"

	if use wxwindows; then
		make_wrapper 7zG "/usr/lib/${PN}/7zG"

		dobin GUI/p7zipForFilemanager
		exeinto /usr/$(get_libdir)/${PN}
		doexe bin/7zG

		insinto /usr/$(get_libdir)/${PN}
		doins -r GUI/{Lang,help}

		if use kde; then
			insinto /usr/share/icons/hicolor/16x16/apps/
			newins GUI/p7zip_16_ok.png p7zip.png

			insinto  /usr/share/apps/konqueror/servicemenus/
			doins GUI/kde/*.desktop
		fi
	fi

	dobin "${FILESDIR}/p7zip" || die

	# gzip introduced in 4.42, so beware :)
	newbin contrib/gzip-like_CLI_wrapper_for_7z/p7zip 7zg || die

	exeinto /usr/$(get_libdir)/${PN}
	doexe bin/7z bin/7za bin/7zr bin/7zCon.sfx || die "doexe bins"
	doexe bin/*.so || die "doexe *.so files"

	doman man1/7z.1 man1/7za.1 man1/7zr.1
	dodoc ChangeLog README TODO

	if use doc ; then
		dodoc DOCS/*.txt
		dohtml -r DOCS/MANUAL/*
	fi

	einfo "Please be aware that rar support was removed (it's nonfree)"
	einfo "You can use app-arch/rar for rar support"
}

