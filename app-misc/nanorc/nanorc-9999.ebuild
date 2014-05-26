# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit git-r3

DESCRIPTION="Our collected nanorc files"
HOMEPAGE="http://j-schmitz.net/"
SRC_URI=""
EGIT_REPO_URI="git://repos.j-schmitz.net/nanorc.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RESTRICT="binchecks strip"

src_install() {
	insinto /usr/share/${PN}
	doins *.nanorc

	if [[ -f "${EPREFIX}"/etc/nanorc ]]; then
		sed \
			-e "/^include \"${EPREFIX//\//\\/}\/usr\/share\/${PN}/d" \
			"${EPREFIX}"/etc/nanorc > "${T}"/nanorc.system || die
		for i in *.nanorc; do
			if ! grep -q ${i} "${T}"/nanorc.system; then
				echo "include \"${EPREFIX}/usr/share/${PN}/${i}\"" >> "${T}"/nanorc.system
			fi
		done
		insinto /etc
		newins "${T}"/nanorc.system nanorc
	fi
}
