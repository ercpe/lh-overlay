# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils toolchain-funcs

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
	epatch "${FILESDIR}/gentoo.patch"
}

src_compile() {
	sed -e "s:tc-getCC:$(tc-getCC):g" \
		-e "s:CCFLAGS:$CFLAGS:g" \
		-i makefile

	emake || die "emake failed"
}

src_install() {
	dobin tcpproxy
	dodoc CHANGES README
	doman tcpproxy.1
}
