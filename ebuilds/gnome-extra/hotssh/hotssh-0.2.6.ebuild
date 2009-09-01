# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit versionator

DESCRIPTION="Interface to Secure Shell, for GNOME and OpenSSH"
HOMEPAGE="http://projects.gnome.org/hotssh/"
SRC_URI="http://ftp.gnome.org/pub/GNOME/sources/${PN}/$(get_version_component_range 1-2)/${P}.tar.bz2"

SLOT="0"
KEYWORDS="~amd64 ~x86"
LICENSE="GPL-2"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}"

src_compile() {
	python ./waf configure --prefix=/usr || die
	python ./waf || die
}

src_install() {
	python ./waf install --destdir="${D}"
}
