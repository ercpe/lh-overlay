# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils

DESCRIPTION="A robust two way (bidirectional) file sync script based on rsync with fault tolerance"
HOMEPAGE="http://www.netpower.fr/osync"
SRC_URI="https://github.com/deajan/osync/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE=""
RDEPEND="${DEPEND} app-shells/bash"

S="${WORKDIR}/${P}"

src_install() {
	insinto /etc/osync
	newins sync.conf sync.conf.example
	doins exclude.list.example

	exeinto /usr/bin
	doexe osync.sh osync-batch.sh ssh_filter.sh

	doinitd osync-srv
}
