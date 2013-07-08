# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils java-pkg-2 java-ant-2

DESCRIPTION="This is a sample skeleton ebuild file"
HOMEPAGE="http://milton.io"
SRC_URI="http://milton.io/maven/io/milton/milton-api/${PV}/${PN}-api-${PV}-sources.jar
	client? ( http://milton.io/maven/io/milton/milton-client/${PV}/${PN}-client-${PV}-sources.jar )
	mail? ( http://milton.io/maven/io/milton/milton-mail-api/${PV}/${PN}-mail-api-${PV}-sources.jar )
	mail-server? ( http://milton.io/maven/io/milton/milton-mail-server/${PV}/${PN}-mail-server-${PV}-sources.jar )
"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="client mail mail-server proxy"

CDEPEND="
	dev-java/commons-codec
	dev-java/commons-io
	dev-java/slf4j
	client? (
		=dev-java/cardme-0.2.9
		dev-java/commons-beanutils:1.7
		dev-java/commons-lang:2.1
		dev-java/httpcomponents-client
		dev-java/jdom
		dev-java/ical4j
	)
"

RDEPEND="${CDEPEND}
	>=virtual/jre-1.5"
DEPEND="
	${CDEPEND}
	app-arch/unzip
	>=virtual/jdk-1.5"

JAVA_ANT_REWRITE_CLASSPATH="yes"
EANT_GENTOO_CLASSPATH="
	commons-codec
	commons-io-1
	slf4j
"

src_unpack() {
	_uz() {
		mkdir -p "${S}"/${PN}-${1}/src || die
		unzip "${DISTDIR}"/${PN}-${1}-${PV}-sources.jar -d "${S}"/${PN}-${1}/src || die
	}
	
	_uz "api"
	use client && _uz "client"
}

src_compile() {
	use client && EANT_GENTOO_CLASSPATH="${EANT_GENTOO_CLASSPATH}
		cardme
		commons-beanutils-1.7
		commons-lang-2.1
		httpcomponents-core
		httpcomponents-client
		jdom-1.0
		ical4j
	"

	_disable() {
		sed -i -e "s/.*"${1}".*//g" "${S}/build.xml" || die 
	}
	
	use client || _disable "milton-client"

	java-pkg-2_src_compile
}

src_prepare() {
	cp -r ${FILESDIR}/${PV}/* "${S}"/ || die
}

# The following src_configure function is implemented as default by portage, so
# you only need to call it if you need a different behaviour.
# This function is available only in EAPI 2 and later.
#src_configure() {
	# Most open-source packages use GNU autoconf for configuration.
	# The default, quickest (and preferred) way of running configure is:
	#econf
	#
	# You could use something similar to the following lines to
	# configure your package before compilation.  The "|| die" portion
	# at the end will stop the build process if the command fails.
	# You should use this at the end of critical commands in the build
	# process.  (Hint: Most commands are critical, that is, the build
	# process should abort if they aren't successful.)
	#./configure \
	#	--host=${CHOST} \
	#	--prefix=/usr \
	#	--infodir=/usr/share/info \
	#	--mandir=/usr/share/man || die
	# Note the use of --infodir and --mandir, above. This is to make
	# this package FHS 2.2-compliant.  For more information, see
	#   http://www.pathname.com/fhs/
#}

# The following src_compile function is implemented as default by portage, so
# you only need to call it, if you need different behaviour.
# For EAPI < 2 src_compile runs also commands currently present in
# src_configure. Thus, if you're using an older EAPI, you need to copy them
# to your src_compile and drop the src_configure function.
#src_compile() {
	# emake (previously known as pmake) is a script that calls the
	# standard GNU make with parallel building options for speedier
	# builds (especially on SMP systems).  Try emake first.  It might
	# not work for some packages, because some makefiles have bugs
	# related to parallelism, in these cases, use emake -j1 to limit
	# make to a single process.  The -j1 is a visual clue to others
	# that the makefiles have bugs that have been worked around.

	#emake || die
#}

# The following src_install function is implemented as default by portage, so
# you only need to call it, if you need different behaviour.
# For EAPI < 4 src_install is just returing true, so you need to always specify
# this function in older EAPIs.
#src_install() {
	# You must *personally verify* that this trick doesn't install
	# anything outside of DESTDIR; do this by reading and
	# understanding the install part of the Makefiles.
	# This is the preferred way to install.
	#emake DESTDIR="${D}" install || die

	# When you hit a failure with emake, do not just use make. It is
	# better to fix the Makefiles to allow proper parallelization.
	# If you fail with that, use "emake -j1", it's still better than make.

	# For Makefiles that don't make proper use of DESTDIR, setting
	# prefix is often an alternative.  However if you do this, then
	# you also need to specify mandir and infodir, since they were
	# passed to ./configure as absolute paths (overriding the prefix
	# setting).
	#emake \
	#	prefix="${D}"/usr \
	#	mandir="${D}"/usr/share/man \
	#	infodir="${D}"/usr/share/info \
	#	libdir="${D}"/usr/$(get_libdir) \
	#	install || die
	# Again, verify the Makefiles!  We don't want anything falling
	# outside of ${D}.

	# The portage shortcut to the above command is simply:
	#
	#einstall || die
#}
