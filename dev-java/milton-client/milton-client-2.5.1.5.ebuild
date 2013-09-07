# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

JAVA_PKG_IUSE="source doc"

inherit eutils java-pkg-2 java-pkg-simple

DESCRIPTION="Milton WebDav library"
HOMEPAGE="http://milton.io"
SRC_URI="http://milton.io/maven/io/milton/${PN}/${PV}/${P}-sources.jar"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE=""

CDEPEND="
	dev-java/commons-beanutils:1.7
	dev-java/commons-io:1
	dev-java/commons-lang:2.1
	dev-java/httpcomponents-client:0
	dev-java/httpcomponents-core:0
	dev-java/slf4j-api:0
	dev-java/ical4j:0
	dev-java/endrick-cache:0
	dev-java/jdom:1.0
	=dev-java/cardme-0.2.9
	=dev-java/milton-api-${PV}:${SLOT}
"

RDEPEND="${CDEPEND}
	>=virtual/jre-1.5"

DEPEND="${CDEPEND}
	>=virtual/jdk-1.5"

JAVA_GENTOO_CLASSPATH="
	commons-beanutils-1.7
	commons-io-1
	commons-lang-2.1
	httpcomponents-core
	httpcomponents-client
	slf4j-api
	ical4j
	endrick-cache
	jdom-1.0
	milton-api
	cardme
"
