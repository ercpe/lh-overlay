# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

DESCRIPTION="ShellEd is a superb shell script editor for Eclipse."
SRC_URI="mirror://sourceforge/shelled/shelled_1_0_3.zip"
HOMEPAGE="http://sourceforge.net/projects/shelled/"
RESTRICT="mirror"
LICENSE="GPL-1"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND="dev-util/eclipse-sdk"
DEPEND="${RDEPEND}"

src_install(){
	insinto /usr/lib/eclipse-3.3/
	doins -r *
}
