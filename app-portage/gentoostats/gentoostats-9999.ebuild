# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

PYTHON_COMPAT=( python2_7 )

inherit git-r3 distutils-r1

DESCRIPTION="Package statistics client"
HOMEPAGE="https://wiki.gentoo.org/wiki/Gentoostats"
SRC_URI=""

EGIT_REPO_URI="git://anongit.gentoo.org/proj/gentoostats.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="
	sys-apps/portage[${PYTHON_USEDEP}]
	>=app-portage/gentoolkit-0.3.0.2[${PYTHON_USEDEP}]
	dev-python/simplejson[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"

python_compile() {
	cd "${S}"/client || die
	distutils-r1_python_compile
}

python_install() {
	cd "${S}"/client || die
	distutils-r1_python_install
}

python_install_all() {
	insinto /etc/gentoostats
	doins client/payload.cfg

	# this doesn't work, why ?
	fowners root:portage /etc/gentoostats/payload.cfg
	fperms 0640 /etc/gentoostats/payload.cfg

	dodoc docs/client.txt

	distutils-r1_python_install_all
}

generate_uuid() {
	if [[ -e /proc/sys/kernel/random/uuid ]]; then
		cat /proc/sys/kernel/random/uuid
	else
		AUTH1=$(< /dev/urandom tr -dc a-zA-Z0-9 | head -c8)
		AUTH2=$(< /dev/urandom tr -dc a-zA-Z0-9 | head -c4)
		AUTH3=$(< /dev/urandom tr -dc a-zA-Z0-9 | head -c4)
		AUTH4=$(< /dev/urandom tr -dc a-zA-Z0-9 | head -c4)
		AUTH5=$(< /dev/urandom tr -dc a-zA-Z0-9 | head -c12)
		echo "${AUTH1}-${AUTH2}-${AUTH3}-${AUTH4}-${AUTH5}"
	fi
}

pkg_postinst() {
	AUTHFILE="${ROOT}/etc/gentoostats/auth.cfg"
	if ! [[ -f "${AUTHFILE}" ]]; then
		elog "Generating uuid and password in ${AUTHFILE}"
		mkdir -p "$(dirname ${AUTHFILE})"
		touch "${AUTHFILE}"
		echo "[AUTH]" >> "${AUTHFILE}"
		echo -n "UUID : " >> "${AUTHFILE}"
		generate_uuid >> "${AUTHFILE}"
		echo -n "PASSWD : " >> "${AUTHFILE}"
		< /dev/urandom tr -dc a-zA-Z0-9 | head -c16 >> "${AUTHFILE}"
	fi
	chown root:portage "${AUTHFILE}"
	chmod 0640 "${AUTHFILE}"
}
