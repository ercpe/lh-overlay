# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit eutils flag-o-matic linux-info toolchain-funcs multilib

DESCRIPTION="Hardware Monitoring user-space utilities"

HOMEPAGE="http://www.lm-sensors.org/"
SRC_URI="http://dl.lm-sensors.org/lm-sensors/releases/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="debug sensord"

COMMON="sensord? ( net-analyzer/rrdtool )"
DEPEND="${COMMON}
		sys-apps/sed"
RDEPEND="${COMMON}
		dev-lang/perl
		virtual/logger"

CONFIG_CHECK="HWMON I2C_CHARDEV I2C"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-${PV}-sensors-detect-gentoo.patch

	if use sensord; then
		sed -i -e 's:^#\(PROG_EXTRA\):\1:' "${S}"/Makefile || die
	fi

	# Respect LDFLAGS
	sed -i -e 's/\$(LIBDIR)$/\$(LIBDIR) \$(LDFLAGS)/g' Makefile || die
	sed -i -e 's/\$(LIBSHSONAME) -o/$(LIBSHSONAME) \$(LDFLAGS) -o/g' lib/Module.mk || die

	sed -i \
		-e '/^WARN/d' \
		-e 's|ALL_CFLAGS := -Wall|ALL_CFLAGS := |g' \
		-e 's:ALL_CFLAGS += -O2:ALL_CFLAGS += :g' \
		Makefile || die
	use debug && sed -1 -e 's|DEBUG := 0|DEBUG := 1|g' Makefile
}

src_compile()  {
	einfo
	einfo "You may safely ignore any errors from compilation"
	einfo "that contain \"No such file or directory\" references."
	einfo

	filter-flags -fstack-protector

	emake CC=$(tc-getCC) \
		|| die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" PREFIX=/usr MANDIR=/usr/share/man LIBDIR=/usr/$(get_libdir) \
		install || die "emake install failed"

	newinitd "${FILESDIR}"/lm_sensors-3-init.d lm_sensors
	newinitd "${FILESDIR}"/fancontrol-init.d fancontrol

	if use sensord; then
		newconfd "${FILESDIR}"/sensord-conf.d sensord
		newinitd "${FILESDIR}"/sensord-init.d sensord
	fi

	dodoc \
		CHANGES CONTRIBUTORS INSTALL README* \
		doc/{donations,fancontrol.txt,fan-divisors,progs,temperature-sensors,vid} \
		|| die

	docinto chips
	dodoc doc/chips/* || die

	docinto developers
	dodoc doc/developers/applications || die
}

pkg_postinst() {
	elog "Please run \`/usr/sbin/sensors-detect' in order to setup"
	elog "/etc/conf.d/lm_sensors."
	elog
	elog "/etc/conf.d/lm_sensors is vital to the init-script."
	elog "Please make sure you also add lm_sensors to the desired"
	elog "runlevel. Otherwise your I2C modules won't get loaded"
	elog "on the next startup."
	elog
	elog "You will also need to run the above command if you're upgrading from"
	elog "<=${PN}-2, as the needed entries in /etc/conf.d/lm_sensors has"
	elog "changed."
	elog
	elog "Be warned, the probing of hardware in your system performed by"
	elog "sensors-detect could freeze your system. Also make sure you read"
	elog "the documentation before running lm_sensors on IBM ThinkPads."
	elog
	elog "Please refer to the lm_sensors documentation for more information."
	elog "(http://www.lm-sensors.org/wiki/Documentation)"
}
