# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit check-reqs

DESCRIPTION="blast db needed for chessire"
HOMEPAGE="http://www-almost.ch.cam.ac.uk/site/index.html"
SRC_URI="http://www-almost.ch.cam.ac.uk/site/Blast/db/nr.00.tar.gz
	 http://www-almost.ch.cam.ac.uk/site/Blast/db/nr.01.tar.gz
	 http://www-almost.ch.cam.ac.uk/site/Blast/db/nr.02.tar.gz"

#ftp://ftp.ncbi.nih.gov/blast/db/
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE=""
RDEPEND=""
DEPEND="${RDEPEND}"

src_unpack() {
	check_reqs 6000
}


src_install() {
	insinto /usr/share/${PN}/nr
	doins * || die "failed to install"
}
