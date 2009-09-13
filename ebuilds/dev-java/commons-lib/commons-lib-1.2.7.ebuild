EAPI="2"

#WANT_ANT_TASKS="ant-commons-net"
JAVA_PKG_IUSE="source"

inherit java-pkg-2 java-ant-2

MY_P="${PN}-${PV//./_}"

DESCRIPTION="A collection of useful utils for java"
HOMEPAGE="http://www.j-schmitz.net"
SRC_URI="http://gentoo.j-schmitz.net/portage-overlay/dev-java/commons-lib/${P}.tar.bz2"

LICENSE="as-is"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="debug"

COMMONS_DEPEND="
	dev-java/commons-lang:2.1
	>=dev-java/xstream-1.3"

RDEPEND="
	virtual/jre:1.6
	${COMMONS_DEPEND}"
DEPEND="
	virtual/jdk:1.6
	${COMMONS_DEPEND}"

RESTRICT="mirror"

JAVA_ANT_ENCODING=UTF-8

EANT_BUILD_TARGET="build-dist"

JAVA_ANT_REWRITE_CLASSPATH="true"
EANT_GENTOO_CLASSPATH="commons-lang-2.1,log4j,xstream"

src_install() {
	java-pkg_newjar release/${PN}.jar ${PN}.jar
}
