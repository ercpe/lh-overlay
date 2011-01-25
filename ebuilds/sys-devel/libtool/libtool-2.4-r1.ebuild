# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/libtool/libtool-2.4-r1.ebuild,v 1.1 2010/11/29 15:12:34 flameeyes Exp $

EAPI="3"

LIBTOOLIZE="true" #225559
inherit eutils autotools multilib

DESCRIPTION="A shared library tool for developers"
HOMEPAGE="http://www.gnu.org/software/libtool/"
SRC_URI="mirror://gnu/${PN}/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="2"
KEYWORDS="~amd64 ~x86"
IUSE="vanilla"

RDEPEND="sys-devel/gnuconfig
	!<sys-devel/autoconf-2.62:2.5
	!<sys-devel/automake-1.10.1:1.10
	!=sys-devel/libtool-2*:1.5"
DEPEND="${RDEPEND}
	>=sys-devel/binutils-2.20
	|| ( app-arch/xz-utils app-arch/lzma-utils )"

src_prepare() {
	sed \
		-e 's:|-threads:|-threads|-fopenmp|-openmp:g' \
		-i libltdl/config/ltmain.sh || die
	if ! use vanilla ; then
		epunt_cxx
		cd libltdl/m4
		epatch "${FILESDIR}"/1.5.20/${PN}-1.5.20-use-linux-version-in-fbsd.patch #109105
		cd ..
		AT_NOELIBTOOLIZE=yes eautoreconf
		cd ..
		AT_NOELIBTOOLIZE=yes eautoreconf
	fi
}

src_configure() {
	# the libtool script uses bash code in it and at configure time, tries
	# to find a bash shell.  if /bin/sh is bash, it uses that.  this can
	# cause problems for people who switch /bin/sh on the fly to other
	# shells, so just force libtool to use /bin/bash all the time.
	export CONFIG_SHELL=/bin/bash

	default
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog* NEWS README THANKS TODO doc/PLATFORMS

	for x in $(find "${D}" -name config.guess -o -name config.sub) ; do
		rm -f "${x}" ; ln -sf /usr/share/gnuconfig/${x##*/} "${x}"
	done
}

pkg_preinst() {
	preserve_old_lib /usr/$(get_libdir)/libltdl.so.3
}

pkg_postinst() {
	preserve_old_lib_notify /usr/$(get_libdir)/libltdl.so.3
}
