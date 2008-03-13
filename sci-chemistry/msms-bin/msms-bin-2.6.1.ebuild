# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="msms is a wrapped version of the library comes with MGLTools"
SRC_URI="x86? ( http://mgltools.scripps.edu/downloads/tars/releases/MSMSRELEASE/REL${PV}/msms_i86Linux2_${PV}.tar.gz )
		 amd64? ( http://mgltools.scripps.edu/downloads/tars/releases/MSMSRELEASE/REL${PV}/msms_i86_64Linux2_${PV}.tar.gz)"
HOMEPAGE="http://mgltools.scripps.edu"
RESTRICT="mirror"
LICENSE="mgltools"
SLOT="0"
KEYWORDS="-* ~x86 ~amd64"
IUSE="static"

src_install() {
	insinto /opt/msms/
	doins atmtypenumbers
	sed -i 's:nawk:gawk:g' {pdb_to_xyzr,pdb_to_xyzrn}
	exeinto /opt/msms/
	doexe pdb_to_xyzr pdb_to_xyzrn
	case "${ARCH}" in
		x86)
			doexe msms.i86Linux2.2.6.1
			dosym ../../opt/msms/msms.i86Linux2.2.6.1 /usr/bin/msms;;
		amd64)
			use !static && doexe msms.x86_64Linux2.2.6.1  && \
			dosym ../../opt/msms/msms.x86_64Linux2.2.6.1 /usr/bin/msms
			use static && doexe msms.x86_64Linux2.2.6.1.staticgcc &&\
			dosym ../../opt/msms/msms.x86_64Linux2.2.6.1.staticgcc /usr/bin/msms;;
		*)
			die || "${Arch} not supported";;
	esac

	dosym ../../opt/msms/pdb_to_xyzr /usr/bin/pdb_to_xyzr
	dosym ../../opt/msms/pdb_to_xyzrn /usr/bin/pdb_to_xyzrn
	dodoc README ReleaseNotes
	doman msms.1
}