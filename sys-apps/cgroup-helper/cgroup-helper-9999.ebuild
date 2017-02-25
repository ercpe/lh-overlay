# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit subversion eutils linux-info

DESCRIPTION="Cgroup responsiveness helper script"
HOMEPAGE="http://en.gentoo-wiki.com/wiki/Improve_responsiveness_with_cgroups"
SRC_URI=""
ESVN_REPO_URI="https://repos.j-schmitz.net/svn/pub/portage-overlay/source/sys-apps/cgroup-helper"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

CONFIG_CHECK="~CGROUPS ~CGROUP_CPUACCT"

src_install() {
	dosbin cgroup_helper_clean
	newinitd initd-cgroup_helper ${PN}
	newconfd confd-cgroup_helper ${PN}

	insinto /etc/profile.d
	newins cgroup_helper_bashrc ${PN}.sh
}
