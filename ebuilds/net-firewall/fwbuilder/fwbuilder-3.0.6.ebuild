# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit qt4 multilib

DESCRIPTION="A firewall GUI"
HOMEPAGE="http://www.fwbuilder.org/"
SRC_URI="mirror://sourceforge/fwbuilder/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+pch"

DEPEND="~net-libs/libfwbuilder-${PV}
	>=dev-java/antlr-2.7.7:0[cxx]
	x11-libs/qt-gui:4"
RDEPEND="${DEPEND}"

src_prepare() {
	qt4_src_prepare

	# Remove bundled antlr
	rm -rf src/antlr

	sed -i \
		-e '/COPYING/d' \
		doc/doc.pro || die "sed doc.pro failed"

	# we'll use our eqmake instead of bundled script to process qmake files
	sed -i \
		-e 's:^. ./runqmake.sh$:echo:' \
		configure || die "sed configure failed"

	# prevent install script from automatically stripping binaries - let portage do that
	sed -i \
		-e 's/s) stripcmd="$stripprog"$/s)/' \
		install.sh || die "sed install.sh failed"

	if ! use pch; then
		sed -i \
				-e '/^PRECOMPILED_HEADER =/,/[^\\]$/d' \
				-e '/^CONFIG += precompile_header/d' \
				src/gui/gui.pro || die "sed for gui.pro failed"
	fi
}

src_configure() {
	econf \
		--with-docdir=/usr/share/doc/${PF}

	for pro_file in $(find "${S}" -name "*.pro"); do
		eqmake4 "${pro_file}" -o "$(dirname ${pro_file})/Makefile" "CONFIG+=nostrip" || die "eqmake4 for ${pro_file} failed"
	done
}

src_install() {
	emake INSTALL_ROOT="${D}" install || die "emake install failed"
	cd doc
	dodoc AUTHORS ChangeLog Credits README* \
		FWBuilder-Routing-LICENSE.txt PatchAcceptancePolicy.txt
	doman fwb*.1
}

pkg_postinst() {
	validate_desktop_entries

	elog "You need to emerge sys-apps/iproute2 on the machine"
	elog "that will run the firewall script."
}
