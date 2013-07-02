# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

JAVA_PKG_IUSE=""

inherit eutils java-pkg-2 versionator

PRE="$(get_version_component_range 4)"
UPSTREAM_DATE="${PRE:3:4}-${PRE:7:2}-${PRE:9:2}"

DESCRIPTION="Lightweight file manager featuring a Norton Commander style interface"
HOMEPAGE="http://www.mucommander.com"
SRC_URI="http://www.mucommander.com/download/nightly/archive/${UPSTREAM_DATE}/mucommander-current.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RESTRICT="mirror"

DEPEND=">=virtual/jdk-1.5
	dev-java/java-config"
RDEPEND="${DEPEND}"

MY_PN="muCommander"
MY_PV=$(version_format_string '$1_$2_$3')
MY_P="${MY_PN}-${MY_PV}"

S="${WORKDIR}/${MY_P}"

src_install() {
	jar xf mucommander.jar images/${MY_PN,,}/icon48_24.png || die
	java-pkg_dojar ${MY_PN,,}.jar

	java-pkg_dolauncher ${MY_PN,,} --java_args "-Djava.system.class.loader=com.mucommander.commons.file.AbstractFileClassLoader"

	dodoc readme.txt

	newicon "${S}/images/mucommander/icon48_24.png" ${PN}.png
	make_desktop_entry ${MY_PN,,} "${MY_PN}" ${PN}
}
