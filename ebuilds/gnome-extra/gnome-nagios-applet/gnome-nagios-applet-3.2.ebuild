# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="To keep an audio-visual tab on what's happening with their Nagios monitoring system"
HOMEPAGE="http://mattwork.potsdam.edu/projects/wiki/index.php/Nagios_Applet"
SRC_URI="${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="sound ssl"
RESTRICT="fetch"

pkg_nofetch(){
	einfo "Fetch http://mattwork.potsdam.edu/software/nagios_applet.tar.gz to"
	einfo "${DISTDIR} and rename it to ${P}.tar.gz"
}

RDEPEND="|| ( gnome-base/gnome-light gnome-base/gnome )
		 dev-perl/gnome2-perl
		 dev-perl/gtk2-perl
		 >=dev-lang/perl-5.6
		 dev-perl/glib-perl
		 dev-perl/libwww-perl
		 dev-perl/gtk2-trayicon
		 ssl? ( dev-perl/IO-Socket-SSL )"
#                 + Perl: Gnome2::Sound
DEPEND="${RDEPEND}
		"

S=${WORKDIR}/Applet

src_install(){
	dobin nagios_applet.pl
	insinto /usr/share/pixmaps/tac_applet/
	doins pixmaps/*
}