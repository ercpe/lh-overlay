# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

JAVA_PKG_IUSE="doc source test"

inherit java-pkg-2 java-ant-2

DESCRIPTION="A comprehensive programming and configuration model for modern Java-based enterprise applications"
HOMEPAGE="http://www.springsource.org/spring-framework"
SRC_URI="https://github.com/SpringSource/spring-framework/archive/v${PV}.RELEASE.tar.gz -> spring-framework-${PV}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="test"

CDEPEND="
	dev-java/commons-logging:0
	dev-java/log4j:0
	dev-java/aspectj:0
	dev-java/asm:4
	dev-java/cglib:3
	<=dev-java/jopt-simple-4.4:0
"

DEPEND=">=virtual/jdk-1.5
	app-arch/zip
	dev-java/jarjar:1
	test? (
		dev-java/junit:4
		dev-java/hamcrest-core:0
	)
	${CDEPEND}"

RDEPEND=">=virtual/jre-1.5
	${CDEPEND}"

S="${WORKDIR}/spring-framework-${PV}.RELEASE/"

EANT_BUILD_XML=${S}/${PN}/build.xml
WANT_ANT_TASKS="jarjar-1"
JAVA_ANT_REWRITE_CLASSPATH="true"
EANT_GENTOO_CLASSPATH="commons-logging,log4j,aspectj,jopt-simple,asm-4"
EANT_TEST_GENTOO_CLASSPATH="${EANT_GENTOO_CLASSPATH},junit-4,hamcrest-core"

java_prepare() {
	cp "${FILESDIR}/${PV}-build.xml" "${S}"/spring-core/build.xml || die

	if use test; then
		# these test cases require jdk 1.7
		rm "${S}"/${PN}/src/test/java/org/springframework/core/annotation/AnnotationAwareOrderComparatorTests.java \
			"${S}"/${PN}/src/test/java/org/springframework/core/style/ToStringCreatorTests.java \
			"${S}"/${PN}/src/test/java/org/springframework/util/MethodInvokerTests.java || die
	fi

	# spring-core requires an own version of asm and cglib which gets renamed in the build.xml
	mkdir "${S}/spring-core/lib/" || die
	java-pkg_jar-from --build-only --into "${S}/spring-core/lib/" asm-4
	java-pkg_jar-from --build-only --into "${S}/spring-core/lib/" cglib-3 cglib.jar
}

src_install() {
	java-pkg_dojar "${S}"/spring-core/dist/{spring-core,asm-renamed,cglib-renamed}.jar

	use source && java-pkg_dosrc "${S}"/${PN}/src/main/java/org/
	use doc && java-pkg_dojavadoc "${S}"/${PN}/dist/apidocs/
}

src_test() {
	java-pkg-2_src_test
}