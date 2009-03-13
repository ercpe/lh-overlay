# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit eutils

DESCRIPTION="A crude interface for running the XDS"
HOMEPAGE="http://cc.oulu.fi/~pkursula/xdsi.html"
SRC_URI=""${PN}"_linux.tar.gz"

LICENSE="as-is"

SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE=""
RDEPEND="sci-chemistry/xds-bin
	dev-lang/tk
	app-shells/tcsh
	sci-visualization/xds-viewer"
DEPEND="${RDEPEND}"

S="${WORKDIR}"

src_prepare() {
	epatch "${FILESDIR}"/${PV}-xdsistart.patch
	epatch "${FILESDIR}"/${PV}-noVIEW.patch

	sed -e \
		'1s:/usr/local/bin/wish:/usr/bin/wish:g' \
		-i *.tcl XDSi4 ANG || \
	die
}

src_install() {

	dobin xdsistart || die

	insinto /opt/${PN}
	doins *mini* xdsconv*.txt f2mtz*txt f2mtz*.com || die

	exeinto /opt/${PN}
	doexe XDSi4 ANG *.tcl bin/linux/* ang2xds outlier.com || die

	insinto /usr/share/doc/${P}/
	doins {help,howto}.txt README

	dosym ../../usr/share/doc/${P}/help.txt /opt/${PN}/help.txt
	dosym ../../usr/share/doc/${P}/howto.txt /opt/${PN}/howto.txt
	dosym ../../usr/share/doc/${P}/README /opt/${PN}/README
}
