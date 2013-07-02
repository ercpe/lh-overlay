# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit git-2

DESCRIPTION="Our collected nanorc files"
HOMEPAGE="http://j-schmitz.net/"
SRC_URI=""
EGIT_REPO_URI="git://j-schmitz.net/nanorc"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

src_install() {
	insinto /usr/share/${PN}
	doins *.nanorc

	if [[ -f "${EPREFIX}"/etc/nanorc ]]; then
		cat "${EPREFIX}"/etc/nanorc | \
			sed 's:^include:#include:g' > nanorc.system
		for i in *.nanorc; do
			echo "" >> nanorc.system
			echo "include \"${EPREFIX}/usr/share/${PN}/${i}\"" >> nanorc.system
		done
	fi

	insinto /etc
	newins nanorc.system nanorc
}
