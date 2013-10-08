# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

AUTOTOOLS_AUTORECONF=true

inherit autotools-utils

DESCRIPTION="A GTK+-based LDAP client"
HOMEPAGE="http://www.gq-project.org/"
SRC_URI="mirror://sourceforge/gqclient/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="kerberos"

RDEPEND="
	dev-libs/cyrus-sasl
	dev-libs/glib:2
	dev-libs/libgcrypt
	dev-libs/libxml2
	dev-libs/openssl
	gnome-base/libglade:2.0
	gnome-base/libgnome-keyring
	net-nds/openldap
	gnome-base/gnome-keyring
	gnome-base/libglade:2.0
	x11-libs/cairo
	x11-libs/gdk-pixbuf:2
	x11-libs/gtk+:2
	x11-libs/pango
	kerberos? ( virtual/krb5 )"
DEPEND="${RDEPEND}
	>=dev-util/intltool-0.35
	virtual/pkgconfig"

PATCHES=(
	"${FILESDIR}"/${P}-no-werror.patch
	"${FILESDIR}"/${P}-glibfix.patch
	"${FILESDIR}"/${P}-openssl.patch
	"${FILESDIR}"/${P}-krb.patch
	"${FILESDIR}"/${P}-out-of-source.patch
	)

src_prepare() {
	sed \
		-e 's/AM_ACLOCAL_INCLUDE/AC_CONFIG_MACRO_DIR/g' \
		-e "s:IT_PROG_INTLTOOL:IT_PROG_INTLTOOL\nAM_GLIB_GNU_GETTEXT:g" \
		-e '/HERZI_CHECK_DEVELOP_CFLAGS/d' \
		-i configure.in || die
	rm missing || die
	rm po/Makefile.in.in || die
	autotools-utils_src_prepare
}

src_configure() {
	local myeconfargs=(
		--enable-browser-dnd
		--enable-cache
		--disable-update-mimedb
		--disable-scrollkeeper
		--disable-werror
		--disable-debugging
		)

#	$(use_with kerberos kerberos-prefix "${EPREFIX}"/usr)
#	doesn't work
	use kerberos &&
		myeconfargs+=( --with-kerberos-prefix="${EPREFIX}"/usr )

	autotools-utils_src_configure
}
