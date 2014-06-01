# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

# we can support ruby20 jruby if all dependencies support it
USE_RUBY="ruby19"
RUBY_FAKEGEM_RECIPE_DOC="rdoc"
RUBY_FAKEGEM_RECIPE_TEST="rspec"

inherit ruby-fakegem

DESCRIPTION="A tool for managing events and logs"
HOMEPAGE="http://logstash.net/"
SRC_URI="https://github.com/elasticsearch/logstash/archive/v${PV}.tar.gz -> ${P}.tar.gz"
LICENSE="Apache-2.0"

SLOT="0"
KEYWORDS="~amd64"
IUSE=""

# see https://github.com/elasticsearch/logstash/blob/master/logstash.gemspec

ruby_add_rdepend "dev-ruby/addressable
		dev-ruby/avl_tree
		dev-ruby/awesome_print
		>=dev-ruby/extlib-0.9.16
		dev-ruby/edn
		dev-ruby/filewatch
		dev-ruby/ffi
		dev-ruby/geoip
		dev-ruby/i18n
		dev-ruby/json
		dev-ruby/mime-types
		dev-ruby/msgpack
		dev-ruby/pry
		dev-ruby/rack
		dev-ruby/sinatra
		dev-ruby/treetop
		dev-ruby/user_agent_parser
		dev-ruby/ruby-grok
		dev-ruby/aws-sdk
		>=dev-ruby/bunny-1.1.8
		dev-ruby/gelf
		dev-ruby/gelfd
		dev-ruby/http
		dev-ruby/mail
		dev-ruby/redis
		dev-ruby/snmplib
		dev-ruby/twitter:5
		dev-ruby/xml-simple
		>=dev-ruby/ffi-rzmq-1.0.0
		"

ruby_add_bdepend "test? (
			dev-ruby/rumbster
			dev-ruby/mocha
			dev-ruby/ruby-insist
		)"

DEPEND="dev-libs/geoip[city]"

RUBY_FAKEGEM_BINWRAP="logstash"
RUBY_FAKEGEM_EXTRAINSTALL="locales patterns"
RUBY_FAKEGEM_TASK_DOC=""

all_ruby_prepare() {
	eerror "--> FIXME FIXME FIXME"
	rm -v spec/runner_spec.rb || die
#			spec/codecs/collectd.rb || die # don't know what the problem is
	eerror "--> FIXME FIXME FIXME"

	# this one does not work with the databases provided by dev-libs/geoip
	rm -v spec/filters/geoip.rb \
	 		spec/inputs/file.rb \
	 		spec/inputs/gelf.rb || die

	# jruby only
	rm -v spec/outputs/{elasticsearch_river,elasticsearch}.rb spec/inputs/log4j.rb || die

}

each_ruby_prepare() {
	# some test cases fail with encoding issues - please cross check
	find -name "*.rb" | xargs sed -i -e "s/Socket.gethostname/Socket.gethostname.encode('UTF-8')/g" || die
}

each_ruby_test() {
	${RUBY} lib/logstash/runner.rb rspec || die
}

each_ruby_install() {
	dosym /usr/share/GeoIP/GeoIPCity.dat $(ruby_fakegem_gemsdir)/gems/${P}/vendor/geoip/GeoLiteCity.dat
	each_fakegem_install
}