# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

MODULE_AUTHOR=RANDERSON
inherit perl-module

DESCRIPTION="Least squares line fit, weighted or unweighted"
HOMEPAGE="http://search.cpan.org/~randerson/Statistics-LineFit-0.07/"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

S="${WORKDIR}/${PN}"

RDEPEND=""
DEPEND="virtual/perl-Module-Build
		${RDEPEND}"
