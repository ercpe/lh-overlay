# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

JAVA_PKG_IUSE=""

inherit eutils java-pkg-2

DESCRIPTION="Simple Logging Facade for Java"
HOMEPAGE="http://www.slf4j.org/"
SRC_URI="http://www.${PN}.org/dist/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="simple log4j nop jcl migrator"

RDEPEND="${CDEPEND}
	log4j? ( dev-java/log4j )
	jcl? ( dev-java/commons-logging )
	>=virtual/jre-1.5"
DEPEND="${CDEPEND}
	>=virtual/jdk-1.5
	dev-java/java-config"

S="${WORKDIR}/${P}"

pkg_dist_dir="${S}/dist"

_build_sub() {
	local sub_name="$1"
	local my_name="${PN}-${sub_name}"
	einfo "Compiling ${my_name}"
	local base_dir="${S}/${my_name}"
	local build_dir="${base_dir}/build"
	local src_dir="${base_dir}/src/main/java"
	local classpath="-classpath "
	local jars=""

	if [ "${sub_name}" != "api" ]; then
		jars="${jars}${pkg_dist_dir}/${PN}-api.jar:"
	fi

	if [ "${sub_name}" == "log4j12" ]; then
		jars="${jars}$(java-pkg_getjars log4j)"
	elif [ "${sub_name}" == "jcl" ]; then
		jars="${jars}$(java-pkg_getjars commons-logging)"
	fi

	if [ "${jars}" != "" ]; then
		classpath="${classpath} ${jars}"
	else
		classpath=""
	fi

	mkdir "${build_dir}" || die
	ejavac ${classpath} -nowarn -d "${build_dir}" $(find ${src_dir} -name "*.java") || die

	jar cfm "${pkg_dist_dir}/${my_name}.jar" "${base_dir}/src/main/resources/META-INF/MANIFEST.MF" -C ${build_dir} . || die "Creating ${my_name} jar failed"
}

src_compile() {
	mkdir "${pkg_dist_dir}" || die
	_build_sub "api"

	use simple && _build_sub "simple"
	use nop && _build_sub "nop"
	use log4j && _build_sub "log4j12"
	use jcl && _build_sub "jcl"
	use migrator && _build_sub "migrator"
}

src_install() {
	java-pkg_dojar ${pkg_dist_dir}/*.jar
}
