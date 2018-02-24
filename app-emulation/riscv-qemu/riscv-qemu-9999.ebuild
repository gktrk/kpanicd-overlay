# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

PYTHON_COMPAT=( python2_7 )
PYTHON_REQ_USE="ncurses,readline"

PLOCALES="bg de_DE fr_FR hu it tr zh_CN"

FIRMWARE_ABI_VERSION="2.9.0-r52"

inherit eutils flag-o-matic linux-info toolchain-funcs multilib python-r1 \
	user udev fcaps readme.gentoo-r1 pax-utils l10n

if [[ ${PV} = *9999* ]]; then
	EGIT_REPO_URI="https://github.com/riscv/riscv-qemu.git"
	inherit git-r3
	SRC_URI=""
else
	SRC_URI="https://github.com/riscv/riscv-qemu/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

DESCRIPTION="QEMU with RISC-V (RV64G, RV32G) Emulation Support"
HOMEPAGE="https://github.com/riscv/riscv-qemu/"

LICENSE="GPL-2 LGPL-2 BSD-2"
SLOT="0"
IUSE="accessibility +aio alsa bluetooth bzip2 +caps +curl debug +fdt
	glusterfs gnutls gtk gtk2 infiniband iscsi +jpeg kernel_linux
	kernel_FreeBSD lzo ncurses nfs nls numa opengl +png
	pulseaudio rbd sasl +seccomp sdl sdl2 selinux smartcard snappy
	spice ssh static static-user systemtap tci test usb usbredir vde
	+vhost-net virgl virtfs +vnc vte xattr xen xfs"

COMMON_TARGETS="riscv32 riscv64"
IUSE_SOFTMMU_TARGETS="${COMMON_TARGETS}"
IUSE_USER_TARGETS="${COMMON_TARGETS}"

use_softmmu_targets=$(printf ' qemu_softmmu_targets_%s' ${IUSE_SOFTMMU_TARGETS})
use_user_targets=$(printf ' qemu_user_targets_%s' ${IUSE_USER_TARGETS})
IUSE+=" ${use_softmmu_targets//qemu/+qemu} ${use_user_targets//qemu/+qemu}"

# Block USE flag configurations known to not work.
REQUIRED_USE="${PYTHON_REQUIRED_USE}
	gtk2? ( gtk )
	sdl2? ( sdl )
	static? ( static-user !alsa !bluetooth !gtk !gtk2 !opengl !pulseaudio )
	virtfs? ( xattr )
	vte? ( gtk )
	|| ( ${use_softmmu_targets} ${use_user_targets} )
"

# Dependencies required for qemu tools (qemu-nbd, qemu-img, qemu-io, ...)
# and user/softmmu targets (qemu-*, qemu-system-*).
#
# Yep, you need both libcap and libcap-ng since virtfs only uses libcap.
#
# The attr lib isn't always linked in (although the USE flag is always
# respected).  This is because qemu supports using the C library's API
# when available rather than always using the extranl library.
ALL_DEPEND="
	>=dev-libs/glib-2.0[static-libs(+)]
	sys-libs/zlib[static-libs(+)]
	systemtap? ( dev-util/systemtap )
	xattr? ( sys-apps/attr[static-libs(+)] )"

# Dependencies required for qemu tools (qemu-nbd, qemu-img, qemu-io, ...)
# softmmu targets (qemu-system-*).
SOFTMMU_TOOLS_DEPEND="
	>=x11-libs/pixman-0.28.0[static-libs(+)]
	accessibility? (
		app-accessibility/brltty[api]
		app-accessibility/brltty[static-libs(+)]
	)
	aio? ( dev-libs/libaio[static-libs(+)] )
	alsa? ( >=media-libs/alsa-lib-1.0.13 )
	bluetooth? ( net-wireless/bluez )
	bzip2? ( app-arch/bzip2[static-libs(+)] )
	caps? ( sys-libs/libcap-ng[static-libs(+)] )
	curl? ( >=net-misc/curl-7.15.4[static-libs(+)] )
	fdt? ( >=sys-apps/dtc-1.4.2[static-libs(+)] )
	glusterfs? ( >=sys-cluster/glusterfs-3.4.0[static-libs(+)] )
	gnutls? (
		dev-libs/nettle:=[static-libs(+)]
		>=net-libs/gnutls-3.0:=[static-libs(+)]
	)
	gtk? (
		gtk2? (
			x11-libs/gtk+:2
			vte? ( x11-libs/vte:0 )
		)
		!gtk2? (
			x11-libs/gtk+:3
			vte? ( x11-libs/vte:2.91 )
		)
	)
	infiniband? ( sys-fabric/librdmacm:=[static-libs(+)] )
	iscsi? ( net-libs/libiscsi )
	jpeg? ( virtual/jpeg:0=[static-libs(+)] )
	lzo? ( dev-libs/lzo:2[static-libs(+)] )
	ncurses? (
		sys-libs/ncurses:0=[unicode]
		sys-libs/ncurses:0=[static-libs(+)]
	)
	nfs? ( >=net-fs/libnfs-1.9.3:=[static-libs(+)] )
	numa? ( sys-process/numactl[static-libs(+)] )
	opengl? (
		virtual/opengl
		media-libs/libepoxy[static-libs(+)]
		media-libs/mesa[static-libs(+)]
		media-libs/mesa[egl,gbm]
	)
	png? ( media-libs/libpng:0=[static-libs(+)] )
	pulseaudio? ( media-sound/pulseaudio )
	rbd? ( sys-cluster/ceph[static-libs(+)] )
	sasl? ( dev-libs/cyrus-sasl[static-libs(+)] )
	sdl? (
		!sdl2? (
			media-libs/libsdl[X]
			>=media-libs/libsdl-1.2.11[static-libs(+)]
		)
		sdl2? (
			media-libs/libsdl2[X]
			media-libs/libsdl2[static-libs(+)]
		)
	)
	seccomp? ( >=sys-libs/libseccomp-2.1.0[static-libs(+)] )
	smartcard? ( >=app-emulation/libcacard-2.5.0[static-libs(+)] )
	snappy? ( app-arch/snappy:=[static-libs(+)] )
	spice? (
		>=app-emulation/spice-protocol-0.12.3
		>=app-emulation/spice-0.12.0[static-libs(+)]
	)
	ssh? ( >=net-libs/libssh2-1.2.8[static-libs(+)] )
	usb? ( >=virtual/libusb-1-r2[static-libs(+)] )
	usbredir? ( >=sys-apps/usbredir-0.6[static-libs(+)] )
	vde? ( net-misc/vde[static-libs(+)] )
	virgl? ( media-libs/virglrenderer[static-libs(+)] )
	virtfs? ( sys-libs/libcap )
	xen? ( app-emulation/xen-tools:= )
	xfs? ( sys-fs/xfsprogs[static-libs(+)] )"

CDEPEND="
	!static? (
		${ALL_DEPEND//\[static-libs(+)]}
		${SOFTMMU_TOOLS_DEPEND//\[static-libs(+)]}
	)
"
DEPEND="${CDEPEND}
	dev-lang/perl
	=dev-lang/python-2*
	sys-apps/texinfo
	virtual/pkgconfig
	kernel_linux? ( >=sys-kernel/linux-headers-2.6.35 )
	gtk? ( nls? ( sys-devel/gettext ) )
	static? (
		${ALL_DEPEND}
		${SOFTMMU_TOOLS_DEPEND}
	)
	static-user? ( ${ALL_DEPEND} )
	test? (
		dev-libs/glib[utils]
		sys-devel/bc
	)"
RDEPEND="${CDEPEND}
	selinux? ( sec-policy/selinux-qemu )"

PATCHES=(
	"${FILESDIR}"/riscv-qemu-9999-binfmt-conf-fix.patch
)

STRIP_MASK="/usr/share/riscv-qemu/palcode-clipper"

QA_PREBUILT="
	usr/share/riscv-qemu/hppa-firmware.img
	usr/share/riscv-qemu/openbios-ppc
	usr/share/riscv-qemu/openbios-sparc64
	usr/share/riscv-qemu/openbios-sparc32
	usr/share/riscv-qemu/palcode-clipper
	usr/share/riscv-qemu/s390-ccw.img
	usr/share/riscv-qemu/s390-netboot.img
	usr/share/riscv-qemu/u-boot.e500"

QA_WX_LOAD="usr/bin/qemu-riscv32
	usr/bin/qemu-riscv64"

DOC_CONTENTS="If you want to register binfmt handlers for qemu user targets:
For openrc:
	# rc-update add qemu-binfmt
For systemd:
	# ln -s /usr/share/qemu/binfmt.d/qemu.conf /etc/binfmt.d/qemu.conf"

pkg_pretend() {
	if use kernel_linux; then
		if ! linux_config_exists; then
			eerror "Unable to check your kernel for config options"
		else
			CONFIG_CHECK="~TUN ~BRIDGE"
			ERROR_TUN="You will need the Universal TUN/TAP driver compiled"
			ERROR_TUN+=" into your kernel or loaded as a module to use the"
			ERROR_TUN+=" virtual network device if using -net tap."
			ERROR_BRIDGE="You will also need support for 802.1d"
			ERROR_BRIDGE+=" Ethernet Bridging for some network configurations."
			use vhost-net && CONFIG_CHECK+=" ~VHOST_NET"
			ERROR_VHOST_NET="You must enable VHOST_NET to have vhost-net"
			ERROR_VHOST_NET+=" support"

			# Now do the actual checks setup above
			check_extra_config
		fi
	fi
}

handle_locales() {
	# Make sure locale list is kept up-to-date.
	local detected sorted
	detected=$(echo $(cd po && printf '%s\n' *.po | grep -v messages.po | sed 's:.po$::' | sort -u))
	sorted=$(echo $(printf '%s\n' ${PLOCALES} | sort -u))
	if [[ ${sorted} != "${detected}" ]] ; then
		eerror "The ebuild needs to be kept in sync."
		eerror "PLOCALES: ${sorted}"
		eerror " po/*.po: ${detected}"
		die "sync PLOCALES"
	fi

	# Deal with selective install of locales.
	if use nls ; then
		# Delete locales the user does not want. #577814
		rm_loc() { rm po/$1.po || die; }
		l10n_for_each_disabled_locale_do rm_loc
	else
		# Cheap hack to disable gettext .mo generation.
		rm -f po/*.po
	fi
}

src_prepare() {
	# Alter target makefiles to accept CFLAGS set via flag-o
	sed -i -r \
		-e 's/^(C|OP_C|HELPER_C)FLAGS=/\1FLAGS+=/' \
		Makefile Makefile.target || die

	default

	# Fix ld and objcopy being called directly
	tc-export AR LD OBJCOPY

	# Verbose builds
	MAKEOPTS+=" V=1"

	# Run after we've applied all patches.
	handle_locales

	# Remove bundled copy of libfdt
	rm -r dtc || die
}

##
# configures qemu based on the build directory and the build type
# we are using.
#
qemu_src_configure() {
	debug-print-function ${FUNCNAME} "$@"

	local buildtype=$1
	local builddir="${S}/${buildtype}-build"

	mkdir "${builddir}"

	local conf_opts=(
		--prefix=/usr
		--sysconfdir=/etc
		--libdir=/usr/$(get_libdir)
		--docdir=/usr/share/doc/${PF}/html
		--with-confsuffix=/${PN}
		--disable-bsd-user
		--disable-guest-agent
		--disable-strip
		--disable-werror
		# We support gnutls/nettle for crypto operations.  It is possible
		# to use gcrypt when gnutls/nettle are disabled (but not when they
		# are enabled), but it's not really worth the hassle.  Disable it
		# all the time to avoid automatically detecting it. #568856
		--disable-gcrypt
		--python="${PYTHON}"
		--cc="$(tc-getCC)"
		--cxx="$(tc-getCXX)"
		--host-cc="$(tc-getBUILD_CC)"
		$(use_enable debug debug-info)
		$(use_enable debug debug-tcg)
		--enable-docs
		$(use_enable tci tcg-interpreter)
		$(use_enable xattr attr)
	)

	# Disable options not used by user targets. This simplifies building
	# static user targets (USE=static-user) considerably.
	conf_notuser() {
		if [[ ${buildtype} == "user" ]] ; then
			echo "--disable-${2:-$1}"
		else
			use_enable "$@"
		fi
	}
	conf_opts+=(
		$(conf_notuser accessibility brlapi)
		$(conf_notuser aio linux-aio)
		$(conf_notuser bzip2)
		$(conf_notuser bluetooth bluez)
		$(conf_notuser caps cap-ng)
		$(conf_notuser curl)
		$(conf_notuser fdt)
		$(conf_notuser glusterfs)
		$(conf_notuser gnutls)
		$(conf_notuser gnutls nettle)
		$(conf_notuser gtk)
		$(conf_notuser infiniband rdma)
		$(conf_notuser iscsi libiscsi)
		$(conf_notuser jpeg vnc-jpeg)
		$(conf_notuser kernel_linux kvm)
		$(conf_notuser lzo)
		$(conf_notuser ncurses curses)
		$(conf_notuser nfs libnfs)
		$(conf_notuser numa)
		$(conf_notuser opengl)
		$(conf_notuser png vnc-png)
		$(conf_notuser rbd)
		$(conf_notuser sasl vnc-sasl)
		$(conf_notuser sdl)
		$(conf_notuser seccomp)
		$(conf_notuser smartcard)
		$(conf_notuser snappy)
		$(conf_notuser spice)
		$(conf_notuser ssh libssh2)
		$(conf_notuser usb libusb)
		$(conf_notuser usbredir usb-redir)
		$(conf_notuser vde)
		$(conf_notuser vhost-net)
		$(conf_notuser virgl virglrenderer)
		$(conf_notuser virtfs)
		$(conf_notuser vnc)
		$(conf_notuser vte)
		$(conf_notuser xen)
		$(conf_notuser xen xen-pci-passthrough)
		$(conf_notuser xfs xfsctl)
	)

	if [[ ! ${buildtype} == "user" ]] ; then
		# audio options
		local audio_opts="oss"
		use alsa && audio_opts="alsa,${audio_opts}"
		use sdl && audio_opts="sdl,${audio_opts}"
		use pulseaudio && audio_opts="pa,${audio_opts}"
		conf_opts+=(
			--audio-drv-list="${audio_opts}"
		)
		use gtk && conf_opts+=( --with-gtkabi=$(usex gtk2 2.0 3.0) )
		use sdl && conf_opts+=( --with-sdlabi=$(usex sdl2 2.0 1.2) )
	fi

	case ${buildtype} in
	user)
		conf_opts+=(
			--enable-linux-user
			--disable-system
			--disable-blobs
			--disable-tools
		)
		local static_flag="static-user"
		;;
	softmmu)
		conf_opts+=(
			--disable-linux-user
			--enable-system
			--disable-tools
		)
		local static_flag="static"
		;;
	esac

	local targets="${buildtype}_targets"
	[[ -n ${targets} ]] && conf_opts+=( --target-list="${!targets}" )

	# Add support for SystemTAP
	use systemtap && conf_opts+=( --enable-trace-backend=dtrace )

	# We always want to attempt to build with PIE support as it results
	# in a more secure binary. But it doesn't work with static or if
	# the current GCC doesn't have PIE support.
	if use ${static_flag}; then
		conf_opts+=( --static --disable-pie )
	else
		tc-enables-pie && conf_opts+=( --enable-pie )
	fi

	echo "../configure ${conf_opts[*]}"
	cd "${builddir}"
	../configure "${conf_opts[@]}" || die "configure failed"

	# FreeBSD's kernel does not support QEMU assigning/grabbing
	# host USB devices yet
	use kernel_FreeBSD && \
		sed -i -E -e "s|^(HOST_USB=)bsd|\1stub|" "${S}"/config-host.mak
}

src_configure() {
	local target

	python_setup

	softmmu_targets= softmmu_bins=()
	user_targets= user_bins=()

	for target in ${IUSE_SOFTMMU_TARGETS} ; do
		if use "qemu_softmmu_targets_${target}"; then
			softmmu_targets+=",${target}-softmmu"
			softmmu_bins+=( "qemu-system-${target}" )
		fi
	done

	for target in ${IUSE_USER_TARGETS} ; do
		if use "qemu_user_targets_${target}"; then
			user_targets+=",${target}-linux-user"
			user_bins+=( "qemu-${target}" )
		fi
	done

	softmmu_targets=${softmmu_targets#,}
	user_targets=${user_targets#,}

	if [[ -z ${user_targets} ]] && [[ -z ${softmmu_targets} ]]; then
		die "Must specify at least one user or softmmu target"
	fi

	[[ -n ${softmmu_targets} ]] && qemu_src_configure "softmmu"
	[[ -n ${user_targets}    ]] && qemu_src_configure "user"
}

src_compile() {
	if [[ -n ${user_targets} ]]; then
		cd "${S}/user-build"
		default
	fi

	if [[ -n ${softmmu_targets} ]]; then
		cd "${S}/softmmu-build"
		default
	fi
}

src_test() {
	if [[ -n ${softmmu_targets} ]]; then
		cd "${S}/softmmu-build"
		pax-mark m */qemu-system-* #515550
		emake -j1 check
		emake -j1 check-report.html
	fi
}

# Generate binfmt support files.
#   - /etc/init.d/qemu-binfmt script which registers the user handlers (openrc)
#   - /usr/share/qemu/binfmt.d/qemu.conf (for use with systemd-binfmt)
generate_initd() {
	local out="${T}/riscv-qemu-binfmt"
	local out_systemd="${T}/riscv-qemu.conf"
	local d="${T}/binfmt.d"

	einfo "Generating qemu binfmt scripts and configuration files"

	# Generate the debian fragments first.
	mkdir -p "${d}"
	"${S}"/scripts/qemu-binfmt-conf.sh \
		--debian \
		--exportdir "${d}" \
		--qemu-path "${EPREFIX}/usr/bin" \
		|| die
	# Then turn the fragments into a shell script we can source.
	sed -E -i \
		-e 's:^([^ ]+) (.*)$:\1="\2":' \
		"${d}"/* || die

	# Generate the init.d script by assembling the fragments from above.
	local f qcpu package interpreter magic mask
	cat "${FILESDIR}"/qemu-binfmt.initd.head >"${out}" || die
	for f in "${d}"/qemu-* ; do
		source "${f}"

		# Normalize the cpu logic like we do in the init.d for the native cpu.
		qcpu=${package#qemu-}
		case ${qcpu} in
		riscv*)   qcpu="riscv";;
		esac

		cat <<EOF >>"${out}"
	if [ "\${cpu}" != "${qcpu}" -a -x "${interpreter}" ] ; then
		echo ':${package}:M::${magic}:${mask}:${interpreter}:'"\${QEMU_BINFMT_FLAGS}" >/proc/sys/fs/binfmt_misc/register
	fi
EOF

		echo ":${package}:M::${magic}:${mask}:${interpreter}:OC" >>"${out_systemd}"

	done
	cat "${FILESDIR}"/qemu-binfmt.initd.tail >>"${out}" || die
}

# Workaround possible file collisions with app-emulation/qemu
# This needs more testing
riscv-qemu_fix_suffixes() {
	local f

	while IFS="" read -d $'\0' -r f ; do
		[[ "$(basename ${f})" =~ riscv ]] && continue
		rename 'qemu' 'riscv-qemu' "${f}" || die
	done < <(find "${ED}" -name 'qemu*' -print0)
}

src_install() {
	if [[ -n ${user_targets} ]]; then
		cd "${S}/user-build"
		emake DESTDIR="${ED}" install

		# Install binfmt handler init script for user targets.
		generate_initd
		doinitd "${T}/riscv-qemu-binfmt"

		# Install binfmt/qemu.conf.
		insinto "/usr/share/riscv-qemu/binfmt.d"
		doins "${T}/riscv-qemu.conf"
	fi

	if [[ -n ${softmmu_targets} ]]; then
		cd "${S}/softmmu-build"
		emake DESTDIR="${ED}" install

		# This might not exist if the test failed. #512010
		[[ -e check-report.html ]] && dohtml check-report.html
	fi

	# Disable mprotect on the qemu binaries as they use JITs to be fast #459348
	pushd "${ED}"/usr/bin >/dev/null
	pax-mark mr "${softmmu_bins[@]}" "${user_bins[@]}" # bug 575594
	popd >/dev/null

	# Install config file example for qemu-bridge-helper
	insinto "/etc/riscv-qemu"
	doins "${FILESDIR}/bridge.conf"

	cd "${S}"
	dodoc Changelog MAINTAINERS docs/specs/pci-ids.txt
	newdoc pc-bios/README README.pc-bios

	if [[ -n ${softmmu_targets} ]]; then
		# Remove SeaBIOS since we're using the SeaBIOS packaged one
		rm "${ED}/usr/share/riscv-qemu/bios.bin"
		rm "${ED}/usr/share/riscv-qemu/bios-256k.bin"

		# Remove vgabios since we're using the seavgabios packaged one
		rm "${ED}/usr/share/riscv-qemu/vgabios.bin"
		rm "${ED}/usr/share/riscv-qemu/vgabios-cirrus.bin"
		rm "${ED}/usr/share/riscv-qemu/vgabios-qxl.bin"
		rm "${ED}/usr/share/riscv-qemu/vgabios-stdvga.bin"
		rm "${ED}/usr/share/riscv-qemu/vgabios-virtio.bin"
		rm "${ED}/usr/share/riscv-qemu/vgabios-vmware.bin"

		# Remove sgabios since we're using the sgabios packaged one
		rm "${ED}/usr/share/riscv-qemu/sgabios.bin"

		# Remove iPXE since we're using the iPXE packaged one
		rm "${ED}"/usr/share/riscv-qemu/pxe-*.rom
	fi

	riscv-qemu_fix_suffixes

	DISABLE_AUTOFORMATTING=true
	readme.gentoo_create_doc
}

pkg_postinst() {
	fcaps cap_net_admin /usr/libexec/riscv-qemu-bridge-helper

	DISABLE_AUTOFORMATTING=true
	readme.gentoo_print_elog
}

pkg_info() {
	echo "Using:"
	echo "  $(best_version app-emulation/spice-protocol)"
	echo "  $(best_version sys-firmware/edk2-ovmf)"
	if has_version 'sys-firmware/edk2-ovmf[binary]'; then
		echo "    USE=binary"
	else
		echo "    USE=''"
	fi
	echo "  $(best_version sys-firmware/ipxe)"
	echo "  $(best_version sys-firmware/seabios)"
	if has_version 'sys-firmware/seabios[binary]'; then
		echo "    USE=binary"
	else
		echo "    USE=''"
	fi
	echo "  $(best_version sys-firmware/sgabios)"
}
