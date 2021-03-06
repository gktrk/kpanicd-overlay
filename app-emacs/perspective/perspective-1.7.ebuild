# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

NEED_EMACS="23"

inherit elisp git-r3

DESCRIPTION="Switch between named perspectives of the editor"
HOMEPAGE="https://github.com/nex3/perspective-el"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~x86"

SITEFILE="50${PN}-gentoo.el"
S="${WORKDIR}/${PN}.el"

EGIT_REPO_URI="https://github.com/nex3/perspective-el.git"
EGIT_COMMIT="c122f7ab0910282abb90cbbbab6704f90b251331"
