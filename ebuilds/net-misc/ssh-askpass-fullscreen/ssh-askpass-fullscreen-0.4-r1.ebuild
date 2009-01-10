# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit toolchain-funcs

DESCRIPTION="A small SSH Askpass replacement written with GTK2."
HOMEPAGE="https://www.cgabriel.org/software/wiki/SshAskpassFullscreen"
SRC_URI="http://www.cgabriel.org/download/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ia64 ppc sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2.0
	!net-misc/gtk2-ssh-askpass"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i -e '2 s/$/$\(LDFLAGS\)/' Makefile
}

src_compile() {

	sed "s:gcc:$(tc-getCC) ${CFLAGS}:g" \
	-i Makefile

	emake LDFLAGS="${LDFLAGS}" || \
	die "compile failed"
}

src_install() {
	dobin ssh-askpass-fullscreen
	doenvd "${FILESDIR}"/99ssh_askpass
	dodoc README AUTHORS
	#doman debian/gtk2-ssh-askpass.1
}
