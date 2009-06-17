# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils toolchain-funcs flag-o-matic

DESCRIPTION="light Unix download accelerator"
HOMEPAGE="http://axel.alioth.debian.org/"
SRC_URI="http://alioth.debian.org/frs/download.php/2718/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
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
	sed -i -e 's/expr/& --/' -e "s/LFLAGS/LIBS/" configure
	epatch "${FILESDIR}"/${PV}-as-needed.patch
}

src_compile() {
	local myconf

	append-lfs-flags

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
