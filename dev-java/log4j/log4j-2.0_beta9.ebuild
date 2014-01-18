# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

JAVA_PKG_IUSE="doc javamail jms jmx source"

inherit java-pkg-2 java-ant-2

MY_PV="${PV/_beta/-beta}"
MY_P="apache-${PN}-${MY_PV}"
MAIN_PV="${PV/_beta9}"

DESCRIPTION="A low-overhead robust logging package for Java"
SRC_URI="mirror://apache/logging/${PN}/${MY_PV}/${MY_P}-src.tar.gz
	http://dev.gentoo.org/~ercpe/distfiles/${CATEGORY}/${PN}/${MY_P}-build.tar.bz2"
HOMEPAGE="http://logging.apache.org/log4j/"

LICENSE="Apache-2.0"
SLOT="2"
KEYWORDS="~amd64 ~x86"
IUSE="doc javamail jms jmx jpa servlet slf4j source"

CDEPEND="dev-java/disruptor:0
	dev-java/jackson:2
	dev-java/jackson-databind:2
	dev-java/osgi-core-api:0
	dev-java/commons-logging:0
	javamail? ( java-virtuals/javamail )
	jms? ( java-virtuals/jms )
	jpa? ( java-virtuals/jpa:2.1.0 )
	servlet? ( java-virtuals/servlet-api:3.0 )
	slf4j? (
		dev-java/slf4j-api:0
		dev-java/slf4j-ext:0
	)"

RDEPEND=">=virtual/jre-1.5
		${CDEPEND}"

DEPEND=">=virtual/jdk-1.5
		${CDEPEND}"

S="${WORKDIR}/${MY_P}-src"

JAVA_ANT_REWRITE_CLASSPATH="true"
JAVA_ANT_IGNORE_SYSTEM_CLASSES="true"
EANT_GENTOO_CLASSPATH="disruptor,jackson-2,jackson-databind-2,osgi-core-api,commons-logging"
EANT_GENTOO_CLASSPATH_EXTRA="${S}/${PN}-api/target/${PN}-api.jar:${S}/${PN}-core/target/${PN}-core.jar"

RESTRICT="test"

java_prepare() {
	EANT_GENTOO_CLASSPATH_EXTRA+=":$(java-config -o)/lib/jconsole.jar"

	# we can't fulfill this dependency atm 
	rm -r "${S}"/log4j-core/src/main/java/org/apache/logging/log4j/core/appender/db/nosql/ \
			"${S}"/log4j-core/src/test/java/org/apache/logging/log4j/core/appender/db/nosql/ || die

	use servlet || epatch "${FILESDIR}"/${MAIN_PV}-no-servlet-api.patch
}

extend_classpath() {
	if use javamail; then
		EANT_GENTOO_CLASSPATH+=",javamail"
		EANT_EXTRA_ARGS+=" -Djavamail-present=true"
	fi
	if use jms; then
		EANT_GENTOO_CLASSPATH+=",jms"
		EANT_EXTRA_ARGS+=" -Djms-present=true"
	fi
	if use jpa; then
		EANT_GENTOO_CLASSPATH+=",jpa-2.1.0"
		EANT_EXTRA_ARGS+=" -Djpa-present=true"
	fi
	if use servlet; then
		EANT_GENTOO_CLASSPATH+=",servlet-api-3.0"
		EANT_EXTRA_ARGS+=" -Dservlet-api-present=true"
	fi
	if use slf4j; then
		EANT_GENTOO_CLASSPATH+=",slf4j-api,slf4j-ext"
		EANT_EXTRA_ARGS+=" -Dslf4j-present=true"
	fi
}

src_compile() {
	extend_classpath
	java-pkg-2_src_compile
}

src_install() {
	java-pkg_dojar "${S}"/log4j-core/target/log4j-core.jar
	java-pkg_dojar "${S}"/log4j-api/target/log4j-api.jar
	java-pkg_dojar "${S}"/log4j-jmx-gui/target/log4j-jmx-gui.jar
	java-pkg_dojar "${S}"/log4j-jcl/target/log4j-jcl.jar
	java-pkg_dojar "${S}"/log4j-1.2-api/target/log4j-1.2-api.jar
	use servlet && java-pkg_dojar "${S}"/log4j-taglib/target/log4j-taglib.jar
	use slf4j && \
		java-pkg_dojar "${S}"/log4j-slf4j-impl/target/log4j-slf4j-impl.jar && \
		java-pkg_dojar "${S}"/log4j-to-slf4j/target/log4j-to-slf4j.jar

	use doc && java-pkg_dojavadoc "${S}"/apidocs
	use source && \
		java-pkg_dosrc "${S}"/log4j-{to-slf4j,taglib,slf4j-impl,jmx-gui,jcl,core,api,1.2-api}/src/main/java/*
}

#src_test() {
#	extend_classpath
#	EANT_TEST_GENTOO_CLASSPATH="${EANT_GENTOO_CLASSPATH},junit-4,ant-junit4,easymock:3.2"
#	WANT_TASKS="ant-junit4"
#	java-pkg-2_src_test
#}
