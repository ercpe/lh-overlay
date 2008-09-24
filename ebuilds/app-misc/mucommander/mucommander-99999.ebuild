# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit subversion java-pkg-2 java-ant-2

MY_P="${PN}-${PV//./_}"


JAVA_PKG_BSFIX="off"
JAVA_PKG_BSFIX_ALL="no"
JAVA_PKG_BSFIX_NAME="local.xml"


DESCRIPTION="http://www.mucommander.com"
HOMEPAGE="http://www.mucommander.com"
ESVN_REPO_URI="https://svn.${PN}.com/${PN}/trunk"

LICENSE="GPL-3"
SLOT="0"
#KEYWORDS="~amd64 ~x86"
KEYWORDS="-*"
IUSE="7zip"

DEPEND="=virtual/jdk-1.6*
	7zip? ( >=app-arch/p7zip-4.4.3 )"
RDEPEND="${DEPEND}"

RESTRICT="mirror"

#S="${WORKDIR}/${P}"

src_unpack(){
	subversion_src_unpack
#	cp ./build/local_template.xml ./local.xml
}

src_compile(){

	eant compress

}
