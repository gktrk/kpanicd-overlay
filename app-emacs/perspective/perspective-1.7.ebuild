# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:

NEED_EMACS="23"

inherit elisp git-2

DESCRIPTION="Switch between named perspectives of the editor"
HOMEPAGE="https://github.com/nex3/perspective-el"

LICENSE="GPL"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~sparc-fbsd ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris ~x86-solaris"
IUSE=""

SITEFILE="50${PN}-gentoo.el"
S="${WORKDIR}/${PN}.el"

EGIT_REPO_URI="https://github.com/nex3/perspective-el.git"
EGIT_COMMIT="c122f7ab0910282abb90cbbbab6704f90b251331"
