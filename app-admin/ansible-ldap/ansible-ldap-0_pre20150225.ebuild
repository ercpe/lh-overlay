# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python2_7 )

inherit python-r1 vcs-snapshot

MY_COMMIT_ID="b6f7cf8f3a90"

DESCRIPTION="Ansible modules for manipulating an LDAP directory"
HOMEPAGE="https://bitbucket.org/psagers/ansible-ldap/overview"
SRC_URI="https://bitbucket.org/psagers/ansible-ldap/get/${MY_COMMIT_ID}.zip -> ${P}.zip"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

S="${WORKDIR}/psagers-${PN}-${MY_COMMIT_ID}"

RDEPEND="dev-python/python-ldap[${PYTHON_USEDEP}]"
DEPEND="app-arch/unzip"

src_prepare() {
	for x in "${S}"/modules/*; do
		mv ${x} ${x}.py || die
	done
}

ansible_ldap_install() {
	python_moduleinto ${PN/-/_}
	python_domodule "${S}"/modules/*
}

src_install() {
	python_foreach_impl ansible_ldap_install
}