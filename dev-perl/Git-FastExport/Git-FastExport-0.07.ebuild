# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

MODULE_AUTHOR=BOOK
inherit perl-module

DESCRIPTION="A module to parse the output of git-fast-export"
HOMEPAGE="http://search.cpan.org/~book/Git-FastExport-0.07/"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND="dev-vcs/git[perl]"
DEPEND="virtual/perl-Module-Build
		${RDEPEND}"
