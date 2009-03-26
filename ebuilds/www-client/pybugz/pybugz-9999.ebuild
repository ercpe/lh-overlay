# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/pybugz/pybugz-0.7.3.ebuild,v 1.11 2008/12/07 11:48:53 vapier Exp $

EAPI="2"

inherit distutils git

EGIT_REPO_URI="git://github.com/ColdWind/pybugz.git"
EGIT_BRANCH="master"

DESCRIPTION="Command line interface to (Gentoo) Bugzilla"
HOMEPAGE="http://pybugz.googlecode.com"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RDEPEND=">=dev-lang/python-2.5[readline]"
DEPEND="${RDEPEND}"
