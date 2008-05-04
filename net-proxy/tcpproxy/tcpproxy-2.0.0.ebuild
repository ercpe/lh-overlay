# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

MY_P="${P}-beta15"

DESCRIPTION="Transparent TCP Proxy"
HOMEPAGE="http://quietsche-entchen.de/cgi-bin/wiki.cgi/proxies/TcpProxy"
SRC_URI="http://quietsche-entchen.de/download/${MY_P}.tar.gz"

RESTRICT="mirror"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch "${FILESDIR}/gentoo.patch"
}

src_compile() {
	emake || die "emake failed"
	einstall || die "einstall failed"
}

src_install() {
	insinto /usr/bin
	doins tcpproxy
	fowners root:root /usr/bin/tcpproxy
	fperms 770 /usr/bin/tcpproxy
	dodoc CHANGES LICENSE README
	doman tcpproxy.1
}
