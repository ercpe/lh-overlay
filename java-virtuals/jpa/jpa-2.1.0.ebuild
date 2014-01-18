# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

inherit java-virtuals-2

DESCRIPTION="Virtual for Java Persistence API (JPA)"
HOMEPAGE="http://www.gentoo.org"
SRC_URI=""

LICENSE="public-domain"
SLOT="${PV}"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-java/eclipse-persistence:${SLOT}"
DEPEND=""

JAVA_VIRTUAL_PROVIDES="eclipse-persistence:${SLOT}"
