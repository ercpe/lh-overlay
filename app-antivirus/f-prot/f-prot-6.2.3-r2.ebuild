# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit eutils

IUSE=""
MY_PN="fp-Linux"
S="${WORKDIR}"/${PN}

DESCRIPTION="Frisk Software's f-prot virus scanner"
HOMEPAGE="http://www.f-prot.com/"
#SRC_URI="http://files.f-prot.com/files/unix-trial/${MY_P}.tar.gz"
SRC_URI="amd64?	( http://files.f-prot.com/files/unix-trial/${MY_PN}.x86.64-ws.tar.gz -> ${P}-amd64.tar.gz )
	x86?	( http://files.f-prot.com/files/unix-trial/${MY_PN}.x86.32-ws.tar.gz -> ${P}-x86.tar.gz )"
DEPEND=""
# unzip and perl are needed for the check-updates.pl script
RDEPEND=">=app-arch/unzip-5.42-r1
	       dev-lang/perl
	       dev-perl/libwww-perl"

SLOT="0"
LICENSE="F-PROT"
KEYWORDS="~amd64 ~x86"

RESTRICT="mirror strip"

src_install() {
	       dodoc doc/CHANGES
	       dodoc README
	       dohtml -r doc/html/*
	       doman doc/man/*
	       exeinto /opt/f-prot
	       doexe fpscan
	       doexe fpupdate
	       insinto /opt/f-prot
	       doins license.key product.data product.data.default *.def
#       doins product.data
#       doins product.data.default
#       doins *.def
	       dosym /opt/f-prot/fpscan /usr/bin/fpscan
	       newins f-prot.conf.default f-prot.conf
	       dosym /opt/f-prot/f-prot.conf /etc/f-prot.conf

	       dodir /opt/f-prot/tools /var/tmp/f-prot
	       keepdir /var/tmp/f-prot
	       min=$( date +%S )
	       echo  "#Start fpupdate, every hour, distribute over the hour" >fp-update.cron
	       echo  "$min */4 * * *  root /opt/f-prot/fpupdate &> /dev/null " >>fp-update.cron
	       insinto /etc/cron.d
	       doins   fp-update.cron
}

pkg_postinst() {
	       elog
	       elog "We've generated the following crontab entries to update the"
	       elog "antivir.def file via fpupdate. Updates will be run hourly at a"
	       elog "randomly picked minute to distribute load, and thus make your updates"
	       elog "faster than if they were run during obvious high load times, e.g. on"
	       elog "the hour."
	       elog
	       elog  "$min * * * *  /opt/f-prot/fpupdate &> /dev/null "
}
