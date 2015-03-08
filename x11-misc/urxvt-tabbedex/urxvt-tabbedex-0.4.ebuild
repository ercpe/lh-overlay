# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/urxvt-perls/urxvt-perls-2.1.ebuild,v 1.2 2015/02/21 23:23:25 radhermit Exp $

EAPI=5

inherit eutils multilib vcs-snapshot

MY_PN=${PN/urxvt-/}

DESCRIPTION="Tabbed plugin for rxvt-unicode with many enhancements"
HOMEPAGE="https://github.com/stepb/urxvt-tabbedex"
SRC_URI="https://github.com/stepb/urxvt-tabbedex/archive/${MY_PN}-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="x11-terms/rxvt-unicode[perl]"

S="${WORKDIR}/${MY_PN}-${PV}"

src_prepare() {
	epatch "${FILESDIR}"/*
}

src_install() {
	insinto /usr/$(get_libdir)/urxvt/perl
	doins ${MY_PN}
}
