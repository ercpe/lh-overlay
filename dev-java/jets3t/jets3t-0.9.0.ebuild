# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

JAVA_PKG_IUSE="source examples"

inherit java-pkg-2 java-ant-2

DESCRIPTION="Java implementation for Amazon S3"
HOMEPAGE="http://www.jets3t.org/"
SRC_URI="https://bitbucket.org/jmurty/${PN}/downloads/${P}.zip
		http://www.centerkey.com/java/browser/myapp/real/bare-bones-browser-launch-3.1.jar"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="servlet tools"

CDEPEND="dev-java/commons-logging:0
	dev-java/commons-codec:0
	dev-java/httpcomponents-core:0
	dev-java/httpcomponents-client:0
	dev-java/java-xmlbuilder:0
	dev-java/jackson:0
	dev-java/jackson-mapper:0
	dev-java/java-uuid-generator:0
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
EANT_GENTOO_CLASSPATH="commons-codec
	commons-logging
	java-xmlbuilder
	java-uuid-generator
	httpcomponents-client
	httpcomponents-core
	jackson
	jackson-mapper"

src_unpack() {
	unpack ${A}
	unzip -n "${S}/src.zip" -d "${S}" || die

	mv "${WORKDIR}"/com "${S}"/src || die
	find "${S}"/src -name "*.class" -delete || die

	find "${S}"/src/ -type f -name "*Test*.java" -delete || die
	find "${S}"/libs/ -type f -delete || die
}

java_prepare() {
	epatch "${FILESDIR}/${PV}-internal-uuids.patch"

	if ! use servlet; then
		rm -r "${S}"/src/org/jets3t/servlets || die
	fi
}

src_compile() {
	use servlet && EANT_GENTOO_CLASSPATH+=",servlet-api-2.4"

	if use tools; then
		EANT_BUILD_TARGET+=" rebuild-cockpit rebuild-synchronize rebuild-uploader rebuild-cockpitlite"
	fi

	java-pkg-2_src_compile
}

src_install() {
	java-pkg_newjar "${S}/jars/${P}.jar" "${PN}.jar"
	java-pkg_newjar "${S}/jars/${PN}-gui-${PV}.jar" "${PN}-gui.jar"
	java-pkg_dolauncher ${PN}-gui --jar ${PN}-gui.jar

	if use tools; then
		for x in cockpit cockpitlite synchronize uploader; do
			java-pkg_newjar "${S}/jars/${x}-${PV}.jar" "${x}.jar"
			java-pkg_dolauncher ${x} --jar ${x}.jar
		done
	fi

	use source && java-pkg_dosrc "${S}/src"
	use examples && java-pkg_doexamples "${S}/src/org/jets3t/samples"
}
