# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit git

EGIT_REPO_URI="git://j-schmitz.net/nanorc"

DESCRIPTION="our nanorc files"
HOMEPAGE="http://j-schmitz.net"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}"

src_install() {
	insinto /usr/share/${PN}
	doins *.nanorc || die

	if [[ -f /etc/nanorc ]]; then
		cat /etc/nanorc | \
			sed 's:^include:#include:g' > nanorc.system
		for i in *.nanorc; do
			echo ""
			echo "include /usr/share/${PN}/${i}" >> nanorc.system
		done
	fi

	insinto /etc
	newins nanorc.system nanorc
}
