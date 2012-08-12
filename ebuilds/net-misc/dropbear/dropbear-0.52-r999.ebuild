# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/dropbear/dropbear-0.52.ebuild,v 1.10 2010/04/20 08:04:34 vapier Exp $

EAPI=4

inherit eutils savedconfig pam user

DESCRIPTION="small SSH 2 client/server designed for small memory environments"
HOMEPAGE="http://matt.ucc.asn.au/dropbear/dropbear.html"
SRC_URI="
	http://matt.ucc.asn.au/dropbear/releases/${P}.tar.bz2
	http://matt.ucc.asn.au/dropbear/testing/${P}.tar.bz2"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="bsdpty minimal multicall pam static syslog zlib"

DEPEND="
	pam? ( virtual/pam )
	zlib? ( sys-libs/zlib )"
RDEPEND="${DEPEND}
	pam? ( >=sys-auth/pambase-20080219.1 )"

REQUIRED_USE="^^ ( pam static )"

set_options() {
	use minimal \
		&& progs="dropbear dbclient dropbearkey" \
		|| progs="dropbear dbclient dropbearkey dropbearconvert scp"
	use multicall && makeopts="${makeopts} MULTI=1"
	use static && makeopts="${makeopts} STATIC=1"
}

pkg_setup() {
	enewgroup sshd 22
	enewuser sshd 22 -1 /var/empty sshd
}

src_prepare() {
	epatch \
		"${FILESDIR}"/dropbear-0.46-dbscp.patch \
		"${FILESDIR}"/dropbear-0.52-fail2ban.patch
	sed \
		-e '/SFTPSERVER_PATH/s:".*":"/usr/lib/misc/sftp-server":' \
		-e '/XAUTH_COMMAND/s:/X11R6/:/:' \
		-i options.h || die
	sed \
		-e '/pam_start/s:sshd:dropbear:' \
		-i svr-authpam.c || die
	restore_config options.h
}

src_configure() {
	econf \
		$(use_enable zlib) \
		$(use_enable pam) \
		$(use_enable !bsdpty openpty) \
		$(use_enable syslog)
	set_options
}

src_compile() {
	emake ${makeopts} PROGRAMS="${progs}"
}

src_install() {
	set_options
	emake install DESTDIR="${D}" ${makeopts} PROGRAMS="${progs}"
	doman *.8
	newinitd "${FILESDIR}"/dropbear.init.d dropbear
	newconfd "${FILESDIR}"/dropbear.conf.d dropbear
	dodoc CHANGES README TODO SMALL MULTI

	# The multi install target does not install the links
	if use multicall ; then
		cd "${D}"/usr/bin
		local x
		for x in ${progs} ; do
			ln -s dropbearmulti ${x} || die "ln -s dropbearmulti to ${x} failed"
		done
		rm -f dropbear
		dodir /usr/sbin
		dosym ../bin/dropbearmulti /usr/sbin/dropbear
		cd "${S}"
	fi
	save_config options.h

	if ! use minimal ; then
		mv "${D}"/usr/bin/{,db}scp || die
	fi

	pamd_mimic system-remote-login dropbear auth account password session \
		|| die "unable to mimic system-remote-login pamd file."
}
