# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 )

inherit python-r1 vcs-snapshot

DESCRIPTION="Ansible XML lookup plugin"
HOMEPAGE="https://github.com/cmprescott/ansible-xml"
SRC_URI="https://github.com/cmprescott/ansible-xml/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="app-admin/ansible[${PYTHON_USEDEP}]
		dev-python/lxml[${PYTHON_USEDEP}]"

ansible_xml_install() {
	python_moduleinto ${PN/-/_}
	python_domodule "${S}"/library/*
}

src_install() {
	python_foreach_impl ansible_xml_install
}
