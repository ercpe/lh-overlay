# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils java-pkg-2 versionator

UPSTREAM_MAIN_PV=$(get_version_component_range 1-2)

DESCRIPTION="A Base64 encode written in java"
HOMEPAGE="http://iharder.sourceforge.net/current/java/base64/"
SRC_URI="mirror://sourceforge/iharder/${PN}/${UPSTREAM_MAIN_PV}/Base64-v${PV}.zip"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=virtual/jre-1.5"
DEPEND=">=virtual/jdk-1.5"

S="${WORKDIR}/${PN^}-v${PV}"

src_prepare() {
	mkdir -p "${S}/net/iharder" || die
	cp "${S}"/*.java "${S}/net/iharder" || die
	sed -i '1i package net.iharder;' "${S}"/net/iharder/*.java || die
}

src_compile() {
	local build_dir="${S}/build"
	mkdir ${build_dir} || die
	ejavac -nowarn -d ${build_dir} $(find -name "*.java")
}

src_install() {
	jar cf "${PN}.jar" -C "${S}/build" . || die "jar failed"
	java-pkg_dojar "${PN}.jar"
}
