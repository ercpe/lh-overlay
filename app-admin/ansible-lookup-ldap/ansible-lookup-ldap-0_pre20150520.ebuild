# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

PYTHON_COMPAT=( python2_7 )

inherit python-r1 vcs-snapshot

MY_COMMIT_ID="2a3afa05682177b63f62086dbbfb892425b5b4a2"

DESCRIPTION="Ansible LDAP lookup plugin"
HOMEPAGE="https://github.com/quinot/ansible-plugin-lookup_ldap"
SRC_URI="https://github.com/quinot/ansible-plugin-lookup_ldap/archive/${MY_COMMIT_ID}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="app-admin/ansible[${PYTHON_USEDEP}]
		dev-python/python-ldap[${PYTHON_USEDEP}]"

ansible_ldap_install() {
	python_moduleinto ${PN/-/_}
	python_domodule "${S}"/lookup_plugins/*
}

src_install() {
	python_foreach_impl ansible_ldap_install
}
