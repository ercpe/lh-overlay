# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
# This ebuild come from http://bugs.gentoo.org/show_bug.cgi?id=130645 - The site http://gentoo.zugaina.org/ only host a copy.
# Small modifications by Ycarus

inherit eutils rpm flag-o-matic multilib

DESCRIPTION="Canon InkJet Printer Driver for Linux (Pixus/Pixma-Series)."
HOMEPAGE="ftp://download.canon.jp/pub/driver/bj/linux/"
RESTRICT="nomirror"

SRC_URI="${HOMEPAGE}${PN}-common-${PV}-1.src.rpm"
LICENSE="as-is" # GPL-2 source and proprietary binaries

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="amd64
	cnijtools
	ip2200
	ip4200
	ip6600d
	ip7500
	mp500"
DEPEND="virtual/ghostscript
	>=net-print/cups-1.1.14
	!amd64? ( sys-libs/glibc
		>=dev-libs/popt-1.6
		>=media-libs/tiff-3.4
		>=media-libs/libpng-1.0.9 )
	amd64? ( >=app-emulation/emul-linux-x86-bjdeps-0.1
		app-emulation/emul-linux-x86-compat
		app-emulation/emul-linux-x86-baselibs )
	cnijtools? ( !amd64? ( >=gnome-base/libglade-0.6
			>=dev-libs/libxml-1.8
			>=x11-libs/gtk+-1.2 )
		amd64? ( >=app-emulation/emul-linux-x86-bjdeps-0.2
			app-emulation/emul-linux-x86-gtklibs ) )"
# >=automake-1.6.3

# Table of supported Printers and it's IDs
# 	driver name	printers ID	probably compatible printers

_pr1="ip2200"	_prid1="256"	_prcomp1="ip1600 mp150/170/450"
_pr2="ip4200"	_prid2="260"	_prcomp2="mp500"
_pr3="ip6600d"	_prid3="265"	_prcomp3="ip6600pd"
_pr4="ip7500"	_prid4="266"	_prcomp4="?"
_pr5="mp500"	_prid5="273"	_prcomp5="ip4200"

###
#   Standard Ebuild-functions
###

pkg_setup() {
	use amd64 && export ABI=x86
	use amd64 && append-flags -L/emul/linux/x86/lib -L/emul/linux/x86/usr/lib -L/usr/lib32 

	_prefix="/usr/local"
	_bindir="/usr/local/bin"
	_libdir="/usr/$(get_libdir)"
	_ppddir="/usr/share/cups/model"

	einfo ""
	einfo " USE-flags\t(description / probably compatible printers)"
	einfo ""
	einfo " cnijtools\t(additional monitoring and maintenance software)"
	einfo " $_pr1\t($_prcomp1)"
	einfo " $_pr2\t($_prcomp2)"
	einfo " $_pr3\t($_prcomp3)"
	einfo " $_pr4\t($_prcomp4)"
	einfo " $_pr5\t($_prcomp5)"
	einfo ""
	if ! (use $_pr1 || use $_pr2 || use $_pr3 || use $_pr4 || use $_pr5); then
		ewarn "You didn't specify any driver model (set it's USE-flag)."
		einfo ""
		einfo "As example:\tbasic MP500 support without maintenance tools"
		einfo "\t\t -> USE=\"mp500\""
		einfo ""
		einfo "Sleeping 10 seconds (Press CTRL+C to abort)"
		einfo ""
		sleep 10
		_autochoose="true"
	else
		_autochoose="false"
	fi
}

src_unpack() {
	rpm_src_unpack || die
	mv ${PN}-common-${PV} ${P} || die # Correcting directory-structure
}

src_compile() {
	cd libs || die
	./autogen.sh --prefix=${_prefix} || die "Error: libs/autoconf.sh failed"
	make || die "Couldn't make libs"

	cd ../pstocanonij || die
	./autogen.sh --prefix=/usr --enable-progpath=${_bindir} || die "Error: pstocanonij/autoconf.sh failed"
	make || die "Couldn't make pstocanonij"

	if use cnijtools; then
		cd ../cngpij || die
		./autogen.sh --prefix=${_prefix} --enable-progpath=${_bindir} || die "Error: cngpij/autoconf.sh failed"
		make || die "Couldn't make cngpij"

		cd ../cngpijmon || die
		./autogen.sh --prefix=${_prefix} || die "Error: cngpijmon/autoconf.sh failed"
		make || die "Couldn't make cngpijmon"
	fi

	cd ..

	_pr=$_pr1 _prid=$_prid1
	if use $_pr || ${_autochoose}; then
		src_compile_pr;
	fi

	_pr=$_pr2 _prid=$_prid2
	if use $_pr || ${_autochoose}; then
		src_compile_pr;
	fi

	_pr=$_pr3 _prid=$_prid3
	if use $_pr || ${_autochoose}; then
		src_compile_pr;
	fi

	_pr=$_pr4 _prid=$_prid4
	if use $_pr || ${_autochoose}; then
		src_compile_pr;
	fi

	_pr=$_pr5 _prid=$_prid5
	if use $_pr || ${_autochoose}; then
		src_compile_pr;
	fi
}

src_install() {
	mkdir -p ${D}${_bindir} || die
	mkdir -p ${D}${_libdir}/cups/filter || die
	mkdir -p ${D}${_ppddir} || die
	mkdir -p ${D}${_libdir}/cnijlib || die

	cd libs || die
	make DESTDIR=${D} install || die "Couldn't make install libs"

	cd ../pstocanonij || die
	make DESTDIR=${D} install || die "Couldn't make install pstocanoncnij"

	if use cnijtools; then
		cd ../cngpij || die
		make DESTDIR=${D} install || die "Couldn't make install cngpij"

		cd ../cngpijmon || die
		make DESTDIR=${D} install || die "Couldn't make install cngpijmon"
	fi

	cd ..

	_pr=$_pr1 _prid=$_prid1
	if use $_pr || ${_autochoose}; then
		src_install_pr;
	fi

	_pr=$_pr2 _prid=$_prid2
	if use $_pr || ${_autochoose}; then
		src_install_pr;
	fi

	_pr=$_pr3 _prid=$_prid3
	if use $_pr || ${_autochoose}; then
		src_install_pr;
	fi

	_pr=$_pr4 _prid=$_prid4
	if use $_pr || ${_autochoose}; then
		src_install_pr;
	fi

	_pr=$_pr5 _prid=$_prid5
	if use $_pr || ${_autochoose}; then
		src_install_pr;
	fi
}

pkg_postinst() {
	einfo ""
	einfo "For installing a printer:"
	einfo " * Restart CUPS: /etc/init.d/cupsd restart"
	einfo " * Go to http://127.0.0.1:631/"
	einfo "   -> Printers -> Add Printer"
	einfo ""
	einfo "If you experience any problems, please visit:"
	einfo " http://forums.gentoo.org/viewtopic-p-3217721.html"
	einfo ""
}


###
#	Custom Helper Functions
###

src_compile_pr()
{
	mkdir ${_pr}
	cp -a ${_prid} ${_pr} || die
	cp -a cnijfilter ${_pr} || die
	cp -a printui ${_pr} || die
	cp -a stsmon ${_pr} || die

	cd ${_pr}/cnijfilter || die # ${_libdir}/bjlib ???
	./autogen.sh --prefix=${_prefix} --program-suffix=${_pr} --enable-libpath=${_libdir}/bjlib --enable-binpath=${_bindir} || die
	make || die "Couldn't make ${_pr}/cnijfilter"

	if use cnijtools; then
		cd ../printui || die
		./autogen.sh --prefix=${_prefix} --program-suffix=${_pr} || die
		make || die "Couldn't make ${_pr}/printui"

		cd ../stsmon || die
		./autogen.sh --prefix=${_prefix} --program-suffix=${_pr} --enable-progpath=${_bindir} || die
		make || die "Couldn't make ${_pr}/stsmon"
	fi

	cd ../..
}

src_install_pr()
{
	cd ${_pr}/cnijfilter || die
	make DESTDIR=${D} install || die "Couldn't make install ${_pr}/cnijfilter"

	if use cnijtools; then
		cd ../printui || die
		make DESTDIR=${D} install || die "Couldn't make install ${_pr}/printui"

		cd ../stsmon || die
		make DESTDIR=${D} install || die "Couldn't make install ${_pr}/stsmon"
	fi

	cd ../..
	cp ${_prid}/libs_bin/*.so.* ${D}${_libdir} || die # install -c -s -m 755
	cp ${_prid}/database/* ${D}${_libdir}/cnijlib || die # install -c -s -m 755
	cp ppd/canon${_pr}.ppd ${D}${_ppddir} || die
}
