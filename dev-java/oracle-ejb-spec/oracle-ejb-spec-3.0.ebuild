# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="5"

inherit java-pkg-2 versionator

MY_PN=ejb
MY_PV=$(replace_all_version_separators _)
MY_P="${MY_PN}-${MY_PV}"
At="${MY_P}-fr-api.zip"

DESCRIPTION="Oracle's Enterprise Java Beans specification"
HOMEPAGE="http://www.oracle.com/technetwork/java/javaee/ejb/index.html"
SRC_URI="${At}"
DOWNLOAD_URL="http://download.oracle.com/otndocs/jcp/ejb-3_0-fr-api-oth-JSpec/"

LICENSE="oracle-ejb-spec-3.0"
SLOT="3.0"
KEYWORDS="~amd64 ~x86"

IUSE=""

RDEPEND=">=virtual/jre-1.5"
DEPEND="app-arch/unzip"

RESTRICT="fetch"

S="${WORKDIR}"

pkg_nofetch() {
	einfo "Please download ${A} from the following URL and place it in ${DISTDIR}:"
	einfo "${DOWNLOAD_URL}"
}

src_compile() {
	:
}

src_install() {
	java-pkg_newjar ${MY_P}-api.jar ${MY_PN}-api.jar
}