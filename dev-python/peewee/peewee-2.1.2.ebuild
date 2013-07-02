# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3} )

inherit distutils-r1

DESCRIPTION="A small ORM for python"
HOMEPAGE="
	http://charlesleifer.com/blog/peewee-was-baroque-so-i-rewrote-it/
	https://github.com/coleifer/peewee"
SRC_URI="https://github.com/coleifer/peewee/archive/2.1.2.tar.gz -> ${P}.tgz"

SLOT="0"
LICENSE="MIT"
KEYWORDS="~amd64 ~x86"
IUSE=""
