JAVA_PKG_IUSE="doc source"

inherit eutils java-pkg-2 java-ant-2

MY_P="${PN}-${PV//./_}"

DESCRIPTION="A simple but powerfull backup solution written in java"
HOMEPAGE="http://www.j-schmitz.net"
SRC_URI="http://gentoo.j-schmitz.net/portage/distfiles/app-admin/jbackup/${P}.tar.bz2"

LICENSE="as-is"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="=virtual/jdk-1.6*
		dev-java/ant-core"
RDEPEND="${DEPEND}"

RESTRICT="mirror"

src_unpack() {
	unpack "${A}"
	cd "${S}"
}

src_compile() {
	cd "${S}"
	eant build-dist
}


src_install() {
	insinto /usr/$(get_libdir)/jbackup/
	doins release/jbackup.jar || die "Could not install jarfile"

	cat >> "${T}"/jbackup <<- EOF
	#!/bin/bash
	$(which java) -jar /usr/$(get_libdir)/jbackup/jbackup.jar
	EOF

	dobin "${T}"/jbackup
}
