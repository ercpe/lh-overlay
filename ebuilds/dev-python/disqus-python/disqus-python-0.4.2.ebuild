# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="2"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils python vcs-snapshot

DESCRIPTION="Python client library for accessing the disqus.com API"
HOMEPAGE="https://github.com/disqus/disqus-python"
SRC_URI="https://github.com/disqus/${PN}/archive/85246c4b69ecffb41889908314bc5bacdc110a55.tar.gz -> ${P}.tar.gz"

SLOT="0"
KEYWORDS="amd64 ~x86"
LICENSE="Apache-2.0"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}"

S="${WORKDIR}"/${P}

PYTHON_MODNAME=disqusapi
