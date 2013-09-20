# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

JAVA_PKG_IUSE="doc examples source test"
WANT_ANT_TASKS="ant-junit"

inherit java-pkg-2 java-ant-2 vcs-snapshot

DESCRIPTION="TestNG is a testing framework inspired from JUnit and NUnit"
HOMEPAGE="http://testng.org/"
SRC_URI="https://github.com/cbeust/${PN}/archive/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="6"
KEYWORDS="~amd64 ~x86"

IUSE=""

CDEPEND="dev-java/ant-core:0
	dev-java/junit:4
	dev-java/bsh:0
	dev-java/jcommander:1.19
	dev-java/qdox:1.6
	dev-java/snakeyaml:0
	dev-java/guice:2"

DEPEND=">=virtual/jdk-1.5
	test? ( dev-java/junit:4 )
	${CDEPEND}"

RDEPEND=">=virtual/jre-1.5
	${CDEPEND}"

JAVA_ANT_REWRITE_CLASSPATH="yes"
JAVA_PKG_BSFIX_NAME="build.xml build-tests.xml"
JAVA_ANT_CLASSPATH_TAGS+=" testng javadoc"
JAVA_PKG_FILTER_COMPILER="ecj-3.7"

EANT_EXTRA_ARGS="-Djar.file=${PN}.jar"

EANT_BUILD_TARGET="compile create-jar"
EANT_GENTOO_CLASSPATH="bsh,qdox-1.6,jcommander-1.19,snakeyaml,guice-2,ant-core,junit-4"
EANT_GENTOO_CLASSPATH_EXTRA="./${PN}.jar"
EANT_TEST_TARGET="tests"

EANT_DOC_TARGET="javadocs"

java_prepare() {
	find -iname "*.jar" -or -iname "*.class" -delete || die

	#remove ivy support
	sed -i -e 's/.*ivy:.*//' build.xml || die
	mkdir lib || die
}

src_install() {
	java-pkg_dojar "${PN}.jar"
	java-pkg_dolauncher ${PN} --main org.testng.TestNG
	java-pkg_register-ant-task

	use doc && java-pkg_dojavadoc javadocs/
	use source && java-pkg_dosrc src/main/java/{org,com}
	use examples && java-pkg_doexamples examples/
}

src_test() {
	java-pkg-2_src_test
}
