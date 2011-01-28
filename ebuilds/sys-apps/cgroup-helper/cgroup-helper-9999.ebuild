# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

inherit subversion eutils linux-info

ESVN_REPO_URI="https://repos.j-schmitz.net/svn/pub/portage-overlay/source/sys-apps/cgroup-helper"

DESCRIPTION="Cgroup responsiveness helper script"
HOMEPAGE="http://en.gentoo-wiki.com/wiki/Improve_responsiveness_with_cgroups"
SRC_URI=""

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

CONFIG_CHECK="~CGROUPS ~CGROUP_CPUACCT"

src_install() {
	dosbin cgroup_helper_clean || die "dosbin failed"
	newinitd initd-cgroup_helper ${PN} || die "newinitd failed"
	newconfd confd-cgroup_helper ${PN} || die "newconfd failed"

	insinto /etc/profile.d
	newins cgroup_helper_bashrc ${PN}.sh || die "newprofiled failed"
}
