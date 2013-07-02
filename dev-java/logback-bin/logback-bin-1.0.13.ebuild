# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils java-pkg-2

MY_PN=${PN/-bin/}

DESCRIPTION="A generic, reliable, fast & flexible logging framework for Java"
HOMEPAGE="http://logback.qos.ch/"
SRC_URI="http://logback.qos.ch/dist/${MY_PN}-${PV}.tar.gz"

LICENSE="|| ( EPL-1.0 LGPL-2.1 )"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=virtual/jre-1.5"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_PN}-${PV}"

src_install() {
	for mod in core classic access; do
		java-pkg_newjar "${S}/${MY_PN}-${mod}-${PV}.jar" "${MY_PN}-${mod}.jar"
	done
}
