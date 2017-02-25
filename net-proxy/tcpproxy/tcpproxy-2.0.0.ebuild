# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit eutils toolchain-funcs

MY_P="${P}-beta15"

DESCRIPTION="Transparent TCP Proxy"
HOMEPAGE="http://quietsche-entchen.de/cgi-bin/wiki.cgi/proxies/TcpProxy"
SRC_URI="http://quietsche-entchen.de/download/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

S="${WORKDIR}"/${MY_P}

src_prepare() {
	epatch "${FILESDIR}/gentoo.patch"

	sed \
		-e "s:tc-getCC:$(tc-getCC):g" \
		-e "s:CCFLAGS:$CFLAGS:g" \
		-e "s: -o : ${LDFLAGS} -o :g" \
		-i makefile || die
}

src_install() {
	dobin tcpproxy
	dodoc CHANGES README
	doman tcpproxy.1
}
