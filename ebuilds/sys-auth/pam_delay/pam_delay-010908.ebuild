# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit pam private

DESCRIPTION="Set the delay on authentication failure to slow down brute-force attacks."
HOMEPAGE="sys-auth/pam_delay"
SRC_URI="${PKG_SERVER}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="mirror"
RDEPEND="sys-libs/pam"
DEPEND="${RDEPEND}"
S="${WORKDIR}/${PN}"

pkg_setup() {
	getpam_mod_dir
}

src_install() {
	exeinto ${PAM_MOD_DIR}
	doexe pam_delay.so
	dohtml pam_delay.html
}

pkg_postinst() {
	einfo "This module should be placed in the list of authentication modules"
	einfo "before any modules that check passwords"
	einfo "USAGE:"
	einfo "auth       required     ${PAM_MOD_DIR}/pam_delay 1s 500ms"
}
