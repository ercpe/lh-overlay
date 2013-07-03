# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/WWW-Dict-Leo-Org/WWW-Dict-Leo-Org-1.34-r2.ebuild,v 1.2 2010/03/30 06:58:35 jlec Exp $

EAPI=5

MODULE_AUTHOR="CTRLSOFT"
MODULE_A="Parse-Pidl-${PV}.tar.gz"

inherit perl-app

DESCRIPTION="An IDL compiler written in Perl"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-lang/perl"
DEPEND="${RDEPEND}"

S="${WORKDIR}"/Parse-Pidl-${PV}
