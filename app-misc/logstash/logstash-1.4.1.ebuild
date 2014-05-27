# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

USE_RUBY="ruby19" #  jruby

inherit ruby-fakegem

DESCRIPTION="A tool for managing events and logs"
HOMEPAGE="http://logstash.net/"
SRC_URI="https://download.elasticsearch.org/${PN}/${PN}/${P}.tar.gz"
LICENSE="Apache-2.0"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="aws aqmp gelf http mail redis snmp twitter xml zeromq"

# see https://github.com/elasticsearch/logstash/blob/master/logstash.gemspec
ruby_add_rdepend "dev-ruby/i18n
		dev-ruby/ffi
		dev-ruby/treetop
		dev-ruby/json
		dev-ruby/pry
		dev-ruby/addressable
		>=dev-ruby/extlib-0.9.16
		dev-ruby/msgpack
	 	dev-ruby/awesome_print
		aws? ( dev-ruby/aws-sdk )
		aqmp? ( >=dev-ruby/bunny-1.1.8 )
		gelf? (
		 	dev-ruby/gelf
		 	dev-ruby/gelfd
		)
		http? ( dev-ruby/http )
		mail? ( dev-ruby/mail )
		redis? ( dev-ruby/redis )
		snmp? ( dev-ruby/snmplib )
		twitter? ( dev-ruby/twitter:5 )
		xml? ( dev-ruby/xml-simple )
		zeromq? (
		 	>=dev-rub/ffi-rzmq-1.0.0
		)
		"

RUBY_FAKEGEM_BINWRAP="logstash"
RUBY_FAKEGEM_EXTRAINSTALL="locales patterns"
RUBY_FAKEGEM_TASK_DOC=""
