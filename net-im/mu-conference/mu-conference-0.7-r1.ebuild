# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils

DESCRIPTION="Multi-User Chat for jabberd"
HOMEPAGE="https://gna.org/projects/mu-conference/"
SRC_URI="http://download.gna.org/mu-conference/${PN}_${PV}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE="mysql"

DEPEND="
	dev-libs/expat
	dev-libs/glib:2
	net-dns/libidn
	dev-perl/Digest-SHA1
	dev-perl/XML-Simple
	|| ( net-im/jabberd net-im/jabberd2 )
	mysql? ( virtual/mysql )"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}_${PV}"

src_prepare() {
	# Fix missing header in src/conference_user.c in order to
	# make emerge happy and avoid QA notice.
	sed \
		-e "/conference.h/ i #define _XOPEN_SOURCE" \
		-i src/conference_user.c || die

	if use mysql; then
		sed -i '/^CFLAGS/ a CFLAGS:=$(CFLAGS) -DHAVE_MYSQL' src/Makefile || die
	else
		# Makefile is broken. Should not always link against mysql
		sed -i 's/$(mysql_config --libs)//' src/Makefile || die
	fi
}

src_install() {
	dobin src/mu-conference
	fowners jabber:jabber /usr/bin/mu-conference
	fperms 750 /usr/bin/mu-conference

	newinitd "${FILESDIR}"/${P}.init mu-conference

	dodoc ChangeLog FAQ mu-conference.sql README

	for s in scripts/room*.pl; do
		dobin ${s}
	done
	for i in log spool; do
		dodir /var/${i}/jabber/mu-conference
		keepdir /var/${i}/jabber/mu-conference
		fowners jabber:jabber /var/${i}/jabber/mu-conference
		fperms 770 /var/${i}/jabber/mu-conference
	done

	insinto /etc/jabber
	newins muc-default.xml mu-conference.xml
	doins style.css

	sed \
		-e 's,./spool/chat.localhost,/var/spool/jabber/mu-conference,g' \
		-e 's,./syslogs,/var/log/jabber,g' \
		-e 's,./logs,/var/log/jabber/mu-conference,g' \
		-e 's,./mu-conference.pid,/var/run/jabber/mu-conference.pid,g' \
		-e "s,../style.css,/etc/jabber/style.css,g" \
		-e "s,7009,5347,g" \
		-i "${D}"/etc/jabber/mu-conference.xml || die "sed failed"
}

pkg_postinst() {
	echo
	elog "For jabberd-2 connection:"
	elog "1. Make sure that the ip and port in /etc/jabber/mu-conference.xml"
	elog "   match the address of your jabberd router."
	elog "2. Set a common secret in mu-conference.xml and router.xml"
	echo
}
