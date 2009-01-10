# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

inherit eutils multilib rpm mozextension

DESCRIPTION="Google Desktop"
HOMEPAGE="http://desktop.google.com/linux/"
SRC_URI="http://dl.google.com/linux/rpm/stable/i386/google-desktop-linux-1.0.2.0061.rpm"

LICENSE="as-is"
SLOT="0"
KEYWORDS="-* ~x86"
IUSE="firefox thunderbird"
RESTRICT="fetch strip"

RDEPEND="virtual/libc
	x86? (
		x11-libs/libX11
		x11-libs/libXi )
	dev-libs/atk
	dev-libs/glib
	x11-libs/gtk+
	x11-libs/pango
	amd64? ( >=app-emulation/emul-linux-x86-xlibs-1.0 )"
DEPEND="${RDEPEND}"

S="${WORKDIR}"

pkg_setup() {
	# Binary x86 package
	has_multilib_profile && ABI="x86"
}

pkg_nofetch() {
	einfo "Please download ${A} yourself from http://desktop.google.com/linux"
	einfo "and place it in ${DISTDIR}"
}

src_unpack() {
	# You must download google-desktop-linux-1.0.1.0060.rpm
	# from desktop.google.com/linux and put it in ${DISTDIR}
	einfo "Unpacking"
	rpm_src_unpack
}

src_install() {

	# do not include gdl-update since its RH specific
	#dodir /etc/cron.hourly

	#insinto /etc/cron.hourly
	#doins etc/cron.hourly/gdl-update

	dodir /opt/google

	insinto /opt/google/desktop
	doins "${S}"/opt/google/desktop/*
	doins "${S}"/opt/google/desktop/.gdl_installed_files

	exeinto /opt/google/desktop/bin
	doexe "${S}"/opt/google/desktop/bin/gdl_box
	doexe "${S}"/opt/google/desktop/bin/gdlinux

	newexe "${S}"/opt/google/desktop/bin/gdl_config gdl_config.bin
	newexe "${S}"/opt/google/desktop/bin/gdl_fs_crawler gdl_fs_crawler.bin
	newexe "${S}"/opt/google/desktop/bin/gdl_indexer gdl_indexer.bin
	newexe "${S}"/opt/google/desktop/bin/gdl_service gdl_service.bin
	newexe "${S}"/opt/google/desktop/bin/gdl_stats gdl_stats.bin
	newexe "${S}"/opt/google/desktop/bin/gdl_update gdl_update.bin

	make_wrapper gdl_config ./gdl_config.bin /opt/google/desktop/bin /opt/google/desktop/lib /opt/google/desktop/bin
	make_wrapper gdl_fs_crawler ./gdl_fs_crawler.bin /opt/google/desktop/bin /opt/google/desktop/lib /opt/google/desktop/bin
	make_wrapper gdl_indexer ./gdl_indexer.bin /opt/google/desktop/bin /opt/google/desktop/lib /opt/google/desktop/bin
	make_wrapper gdl_service ./gdl_service.bin /opt/google/desktop/bin /opt/google/desktop/lib /opt/google/desktop/bin
	make_wrapper gdl_stats ./gdl_stats.bin /opt/google/desktop/bin /opt/google/desktop/lib /opt/google/desktop/bin
	make_wrapper gdl_update ./gdl_update.bin /opt/google/desktop/bin /opt/google/desktop/lib /opt/google/desktop/bin

	insinto /opt/google/desktop/resource
	doins "${S}"/opt/google/desktop/resource/*

	insinto /opt/google/desktop/xdg
	doins "${S}"/opt/google/desktop/xdg/*

	insinto /usr/bin
	dosym /opt/google/desktop/bin/gdlinux /usr/bin/gdlinux

	into /opt/google/desktop

	insinto /opt/google/desktop
	dolib.so "${S}"/opt/google/desktop/lib/*

	dodir /var/cache/google/desktop
	keepdir /var/cache/google/desktop

	fperms 755 /var/cache/google
	fperms 777 /var/cache/google/desktop
	fperms o+t /var/cache/google/desktop

	cd "${S}"/opt/google/desktop/xdg/
	insinto /usr/share/desktop-directories
	doins google-gdl.directory
	domenu google-gdl.desktop google-gdl-preferences.desktop

	# Install Extensions
	declare MOZILLA_FIVE_HOME
	if use firefox; then
		if has_version '>=www-client/mozilla-firefox-1.5'; then
			MOZILLA_FIVE_HOME="/usr/$(get_libdir)/mozilla-firefox"
			xpi_install "${S}"/opt/google/desktop/plugin/firefox \
			|| die "xpi install for firefox failed!"
		fi
		if has_version '>=www-client/mozilla-firefox-bin-1.5'; then
			MOZILLA_FIVE_HOME="/opt/firefox"
			xpi_install "${S}"/opt/google/desktop/plugin/firefox \
			|| die "xpi install for firefox-bin failed!"
		fi
	fi
	if use thunderbird; then
		if has_version '>=mail-client/mozilla-thunderbird-1.5'; then
			MOZILLA_FIVE_HOME="/usr/$(get_libdir)/mozilla-thunderbird"
			xpi_install "${S}"/opt/google/desktop/plugin/thunderbird \
			|| die "xpi install for thunderbird failed!"
		fi
		if has_version '>=mail-client/mozilla-thunderbird-bin-1.5'; then
			MOZILLA_FIVE_HOME="/opt/thunderbird"
			xpi_install "${S}"/opt/google/desktop/plugin/thunderbird \
			|| die "xpi install for thunderbird-bin failed!"
		fi
	fi
}
