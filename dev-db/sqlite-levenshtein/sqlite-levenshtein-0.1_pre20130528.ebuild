# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils vcs-snapshot

GIT_COMMIT="5b826e4202626c7ebc33ce9fad6265aa5c2bbe19"

DESCRIPTION="Levenshtein distance function for SQLite"
HOMEPAGE="https://github.com/mateusza/SQLite-Levenshtein"
SRC_URI="https://github.com/mateusza/SQLite-Levenshtein/archive/${GIT_COMMIT}.tar.gz -> ${PN}.tar.gz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE=""

S="${WORKDIR}/${PN}"

DEPEND="dev-db/sqlite"
RDEPEND="${DEPEND}"
