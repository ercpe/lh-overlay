# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

JAVA_PKG_IUSE="doc source"

inherit eutils java-pkg-2 java-pkg-simple

DESCRIPTION="A http client library"
HOMEPAGE="http://www.innovation.ch/java/HTTPClient/"
SRC_URI="http://www.innovation.ch/java/HTTPClient/HTTPClient.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="${CDEPEND}
	>=virtual/jre-1.6"
DEPEND="${CDEPEND}
	>=virtual/jdk-1.6"

JAVA_ENCODING="iso8859-1"

java_prepare() {
	rm -r "${S}"/HTTPClient/alt || die
	find "${S}" -type f -name "*.class" -delete || die
	find "${S}" -type f -name "*.java" | xargs sed -i -e 's:\benum\b:enumx:g' || die
}
