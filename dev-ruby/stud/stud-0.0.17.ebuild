# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

USE_RUBY="ruby19 jruby"

inherit ruby-fakegem

DESCRIPTION="Implementation of various software patterns"
HOMEPAGE="https://github.com/jordansissel/ruby-stud"
SRC_URI="http://dev.gentoo.org/~ercpe/distfiles/${CATEGORY}/${PN}/${P}.tar.bz2"
LICENSE="Apache-2.0"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

#DEPEND=""
RDEPEND="${DEPEND}"
# dev-ruby/i18n

#RUBY_FAKEGEM_BINWRAP="logstash"
#RUBY_FAKEGEM_EXTRAINSTALL="locales patterns"
#RUBY_FAKEGEM_TASK_DOC=""
