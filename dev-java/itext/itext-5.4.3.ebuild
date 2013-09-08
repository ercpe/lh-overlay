# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-pkg-simple

DESCRIPTION="Java library that generate documents in the Portable Document Format (PDF) and/or HTML."
HOMEPAGE="http://itextpdf.com"
SRC_URI="mirror://sourceforge/${PN}/${P}.zip"

LICENSE="AGPL-3"
SLOT="5"
KEYWORDS="~amd64 ~x86"

COMMON_DEP="
	=dev-java/bcmail-1.49*
	=dev-java/bcprov-1.49*
	=dev-java/bcpkix-1.49*
	dev-java/xml-security:0
"

RDEPEND="${COMMON_DEP}
	>=virtual/jre-1.5"

DEPEND="${COMMON_DEP}
	>=virtual/jdk-1.5
	app-arch/unzip"

src_unpack() {
	default
	unpack ./${PN}{pdf,-xtra}-${PV}-sources.jar
}

java_prepare() {
	# Extract resources from precompiled jar
	mkdir target/classes -p || die
	pushd target/classes > /dev/null || die
		declare -a resources
		resources=( $(jar -tf "${WORKDIR}"/${PN}pdf-${PV}.jar \
			| sed -e '/class$/d' -e '/\/$/d' -e '/META-INF/d') )
		assert
		jar -xf "${WORKDIR}"/${PN}pdf-${PV}.jar "${resources[@]}" || die
	popd > /dev/null

	find "${WORKDIR}" -name '*.jar' -delete || die
}

JAVA_GENTOO_CLASSPATH="bcmail,bcprov,bcpkix,xml-security"
