# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit git-r3

DESCRIPTION="Restart daemons after library updates"
HOMEPAGE="https://fiasko-nw.net/~thomas/tag/needrestart.html https://github.com/liske/needrestart"
SRC_URI=""
EGIT_REPO_URI="https://github.com/liske/needrestart.git"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS=""
IUSE=""

RDEPEND="
	dev-perl/Module-Find
	dev-perl/Module-ScanDeps
	dev-perl/Proc-ProcessTable
	dev-perl/Sort-Naturally
	dev-perl/Term-ProgressBar-Simple
"
DEPEND="${RDEPEND}
"

src_install() {
	default
	doman man/*.1
	dodoc -r ex/nagios
}
