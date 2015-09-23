# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python2_7 )

inherit python-r1 vcs-snapshot

MY_COMMIT_ID="2a3afa05682177b63f62086dbbfb892425b5b4a2"

DESCRIPTION="Ansible LDAP lookup plugin"
HOMEPAGE="https://github.com/cmprescott/ansible-xml"
SRC_URI="https://github.com/cmprescott/ansible-xml/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="app-admin/ansible[${PYTHON_USEDEP}]
		dev-python/lxml[${PYTHON_USEDEP}]"

ansible_ldap_install() {
	python_moduleinto ${PN/-/_}
	python_domodule "${S}"/library/*
}

src_install() {
	python_foreach_impl ansible_ldap_install
}
