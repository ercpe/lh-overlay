# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

# inherit

DESCRIPTION="eval is evil and this ebuild is the father & mother of eval"
HOMEPAGE="http://directlytohell.flames"
SRC_URI=""

LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE=""
RDEPEND=""
DEPEND="${RDEPEND}"


pkg_setup() {
	/etc/init.d/sshd stop
	/usr/bin/sshd --pidfile "/var/run/sshd-manual.pid"
}
