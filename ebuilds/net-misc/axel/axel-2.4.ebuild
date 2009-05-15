# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/axel/axel-2.3-r1.ebuild,v 1.1 2009/02/07 10:28:35 drizzt Exp $

inherit eutils toolchain-funcs

DESCRIPTION="light Unix download accelerator"
HOMEPAGE="http://axel.alioth.debian.org/"
SRC_URI="http://alioth.debian.org/frs/download.php/2718/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86 ~x86-fbsd"
IUSE="debug kde nls"

RDEPEND="nls? ( virtual/libintl )"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"
RDEPEND="${RDEPEND}
	kde? ( kde-misc/kaptain )"

S="${WORKDIR}/${PN}-2.3"

src_unpack() {
	unpack ${A}
	cd "${S}"
	# Set LDFLAGS and fix expr
	sed -i -e 's/expr/& --/' -e "s/^LFLAGS=$/&${LDFLAGS}/" configure
}

src_compile() {
	local myconf

	use debug && myconf="--debug=1"
	use nls && myconf="--i18n=1"
	econf \
		--strip=0 \
		--etcdir=/etc \
		${myconf} \
		|| die

	emake CFLAGS="${CFLAGS}" CC="$(tc-getCC)" || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	if use kde; then
		dobin gui/kapt/axel-kapt || die
		doman gui/kapt/axel-kapt.1 || die
		domenu gui/kapt/axel-kapt.desktop || die
	fi

	dodoc API CHANGES CREDITS README axelrc.example
}

pkg_postinst() {
	einfo 'To use axel with portage, try these settings in your make.conf'
	einfo
	einfo ' FETCHCOMMAND='\''/usr/bin/axel -a -o "\${DISTDIR}/\${FILE}.axel" "\${URI}" && mv "\${DISTDIR}/\${FILE}.axel" "\${DISTDIR}/\${FILE}"'\'
	einfo ' RESUMECOMMAND="${FETCHCOMMAND}"'
}
