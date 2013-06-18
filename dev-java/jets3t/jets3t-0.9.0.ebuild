# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

JAVA_PKG_IUSE="doc source"

inherit eutils java-pkg-2 java-ant-2

DESCRIPTION="Java implementation for Amazon S3"
HOMEPAGE="http://www.jets3t.org/"
SRC_URI="https://bitbucket.org/jmurty/${PN}/downloads/${P}.zip"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="servlet"

CDEPEND="dev-java/commons-logging
	dev-java/commons-codec
	dev-java/httpcomponents-client
	dev-java/java-xmlbuilder
	dev-java/jackson
	servlet? ( java-virtuals/servlet-api:2.4 )
"

RDEPEND="${CDEPEND}
	>=virtual/jre-1.5"
DEPEND="${CDEPEND}
	app-arch/unzip
	>=virtual/jdk-1.5"

S="${WORKDIR}/${P}"

JAVA_ANT_REWRITE_CLASSPATH="yes"
EANT_BUILD_TARGET="rebuild-service"
EANT_DOC_TARGET=""
COMMON_CLASSPATH="commons-codec
	commons-logging
	java-xmlbuilder
	java-uuid-generator
	httpcomponents-client
	httpcomponents-core
	jackson
"

src_unpack() {
	unpack ${A}
	unzip -n "${S}/src.zip" -d "${S}" || die
	if use doc; then
		unzip -n "${S}/api-docs.zip" -d "${S}" || die
	fi
	rm -r "${S}"/libs/* || die
}

src_prepare() {
	if use servlet; then
		epatch "${FILESDIR}/${PV}-internal-uuids.patch"
	else
		rm -r "${S}"/src/org/jets3t/servlets || die
	fi

	# test, samples and gui apps not finished
	rm -r "${S}"/src/org/jets3t/{gui,apps} || die
	rm -r "${S}"/src/org/jets3t/tests || die
	rm -r "${S}"/src/org/jets3t/samples || die
}

src_compile() {
	local classpath="${COMMON_CLASSPATH}"
	use servlet && classpath="${classpath} servlet-api-2.4"

	EANT_GENTOO_CLASSPATH="${classpath}"
	java-pkg-2_src_compile
}

src_install() {
	java-pkg_newjar "${S}/jars/${P}.jar" "${PN}.jar"
	use source && java-pkg_dosrc "${S}/src"
	use doc && java-pkg_dohtml -r "${S}"/api-docs
}
