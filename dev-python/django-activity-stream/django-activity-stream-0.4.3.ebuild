# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

PYTHON_MODNAME="bootstrap"

DESCRIPTION="Creating activities from the actions on your site following the Activity Streams specification"
HOMEPAGE="https://github.com/justquick/django-activity-stream http://justquick.github.com/django-activity-stream/"
SRC_URI="http://gentoo.j-schmitz.net/portage-overlay/${CATEGORY}/${PN}/${P}.tar.bz2"
RESTRICT="primaryuri"

SLOT="0"
KEYWORDS="~amd64 ~x86"
LICENSE="as-is"
IUSE=""

RDEPEND=">dev-python/django-1.2"
DEPEND=""
