# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-pkg-simple

REL_DATE="201304241213"
DESCRIPTION="Eclipse reference implementation of the JPA ${SLOT}"
HOMEPAGE="http://www.eclipse.org/eclipselink/"
SRC_URI="http://git.eclipse.org/c/eclipselink/javax.persistence.git/snapshot/javax.persistence-${PV}.v${REL_DATE}.tar.bz2"

LICENSE="EPL-1.0"
SLOT="2.1.0"
KEYWORDS="~amd64 ~x86"

IUSE=""

CDEPEND="dev-java/osgi-core-api:0"

RDEPEND=">=virtual/jre-1.5
	${CDEPEND}"

DEPEND=">=virtual/jdk-1.5
	${CDEPEND}"

S="${WORKDIR}/javax.persistence-${PV}.v${REL_DATE}"

JAVA_GENTOO_CLASSPATH="osgi-core-api"

java_prepare() {
	rm "${S}"/build.xml "${S}"/pom.xml || die
}
