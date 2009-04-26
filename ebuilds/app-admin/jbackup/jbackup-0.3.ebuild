inherit eutils java-pkg-2 java-ant-2 multilib

MY_P="${PN}-${PV//./_}"

DESCRIPTION="A simple but powerfull backup solution written in java"
HOMEPAGE="http://www.j-schmitz.net"
SRC_URI="http://gentoo.j-schmitz.net/private-overlay/distfiles/app-admin/jbackup/${PF}.tar.bz2"

LICENSE="as-is"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="debug"

DEPEND="=virtual/jdk-1.6*
		dev-java/ant-core"
RDEPEND="${DEPEND}"

RESTRICT="mirror"

src_compile() {
	cd "${S}"

	ANT_TARGET="build-dist";
	if use debug; then
		ANT_TARGET="build-dist-debug";
	fi
	eant $ANT_TARGET
}


src_install() {
	insinto /usr/$(get_libdir)/jbackup/
	doins release/jbackup.jar || die "Could not install jarfile"

	cat >> "${T}"/jbackup <<- EOF
	#!/bin/bash
	$(which java) -jar /usr/$(get_libdir)/jbackup/jbackup.jar \$@
	EOF

	dobin "${T}"/jbackup
}
