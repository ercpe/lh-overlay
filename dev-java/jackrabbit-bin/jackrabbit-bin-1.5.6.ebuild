# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils java-pkg-2

MY_PN=${PN/-bin}

DESCRIPTION="A fully conforming implementation of the Content Repository for Java Technology API"
HOMEPAGE="http://jackrabbit.apache.org/"
#SRC_URI="mirror://apache/${MY_PN}/${PV}/${MY_PN}-standalone-${PV}.jar"
SRC_URI="http://archive.apache.org/dist/${MY_PN}/${PV}/binaries/${MY_PN}-standalone-${PV}.jar"

LICENSE="Apache-2.0"
SLOT="1"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=virtual/jre-1.5"
RDEPEND="${DEPEND}"

S="${WORKDIR}"

src_unpack() {
	echo -n ""
}

src_compile() {
	echo -n ""
}

src_install() {
	java-pkg_newjar "${DISTDIR}/${A}" "${A/-${PV}}"
}