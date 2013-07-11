# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils java-pkg-2 java-ant-2

DESCRIPTION="This is a sample skeleton ebuild file"
HOMEPAGE="http://milton.io"
SRC_URI="http://milton.io/maven/io/milton/milton-api/${PV}/${PN}-api-${PV}-sources.jar
	client? ( http://milton.io/maven/io/milton/milton-client/${PV}/${PN}-client-${PV}-sources.jar )
	mail? ( http://milton.io/maven/io/milton/milton-mail-api/${PV}/${PN}-mail-api-${PV}-sources.jar )
"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="client mail"

CDEPEND="
	dev-java/commons-codec
	dev-java/commons-io
	dev-java/slf4j
	client? (
		=dev-java/cardme-0.2.9
		dev-java/commons-beanutils:1.7
		dev-java/commons-lang:2.1
		dev-java/httpcomponents-client
		dev-java/endrick-cache
		dev-java/jdom:1.0
		dev-java/ical4j
	)
	mail? (
		java-virtuals/javamail
	)
"

RDEPEND="${CDEPEND}
	>=virtual/jre-1.5"
DEPEND="
	${CDEPEND}
	app-arch/unzip
	>=virtual/jdk-1.5"

JAVA_ANT_REWRITE_CLASSPATH="yes"
EANT_GENTOO_CLASSPATH="
	commons-codec
	commons-io-1
	endrick-common
	endrick-cache
	slf4j
"

src_prepare() {
	cp -r "${FILESDIR}"/${PV}/* "${S}"/ || die
}

src_unpack() {
	_uz() {
		mkdir -p "${S}"/${PN}-${1}/src || die
		unzip "${DISTDIR}"/${PN}-${1}-${PV}-sources.jar -d "${S}"/${PN}-${1}/src || die
	}

	_uz "api"
	use client && _uz "client"
	use mail && _uz "mail-api"
}

src_compile() {
	use client && EANT_GENTOO_CLASSPATH="${EANT_GENTOO_CLASSPATH}
		cardme
		commons-beanutils-1.7
		commons-lang-2.1
		httpcomponents-core
		httpcomponents-client
		jdom-1.0
		ical4j
	"
	use mail &&  EANT_GENTOO_CLASSPATH="${EANT_GENTOO_CLASSPATH}
		javamail"

	_disable() {
		sed -i -e "s/.*"${1}".*//g" "${S}/build.xml" || die
	}

	use client || _disable "${PN}-client"
	use mail || _disable "${PN}-mail-api"

	java-pkg-2_src_compile
}

src_install() {
	java-pkg_dojar "${S}"/${PN}-api/dist/${PN}-api.jar
	use client && java-pkg_dojar "${S}"/${PN}-client/dist/${PN}-client.jar
	use mail && java-pkg_dojar "${S}"/${PN}-mail-api/dist/${PN}-mail-api.jar
}
