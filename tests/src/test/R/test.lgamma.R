#
# Renjin : JVM-based interpreter for the R language for the statistical analysis
# Copyright © 2010-2018 BeDataDriven Groep B.V. and contributors
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, a copy is available at
# https://www.gnu.org/licenses/gpl-2.0.txt
#

# Generated by gen-math-unary-tests.R using GNU R version 3.2.0 (2015-04-16)
library(hamcrest)
lgamma.foo <- function(...) 41
Math.bar <- function(...) 44
test.lgamma.1 <- function() assertThat(lgamma(-0.01), identicalTo(4.6110249927528, tol = 0.000100))
test.lgamma.2 <- function() assertThat(lgamma(-0.1), identicalTo(2.36896133272879, tol = 0.000100))
test.lgamma.3 <- function() assertThat(lgamma(-1), identicalTo(Inf))
test.lgamma.4 <- function() assertThat(lgamma(-1.5), identicalTo(0.860047015376481, tol = 0.000100))
test.lgamma.5 <- function() assertThat(lgamma(-2), identicalTo(Inf))
test.lgamma.6 <- function() assertThat(lgamma(-2.5), identicalTo(-0.056243716497674, tol = 0.000100))
test.lgamma.7 <- function() assertThat(lgamma(-4), identicalTo(Inf))
test.lgamma.8 <- function() assertThat(lgamma(-10), identicalTo(Inf))
test.lgamma.9 <- function() assertThat(lgamma(-100), identicalTo(Inf))
test.lgamma.10 <- function() assertThat(lgamma(-0.785398), identicalTo(1.69107451511246, tol = 0.000100))
test.lgamma.11 <- function() assertThat(lgamma(-1.5708), identicalTo(0.833991354922988, tol = 0.000100))
test.lgamma.12 <- function() assertThat(lgamma(-3.14159), identicalTo(0.015596144828048, tol = 0.000100))
test.lgamma.13 <- function() assertThat(lgamma(-6.28319), identicalTo(-5.71845293163205, tol = 0.000100))
test.lgamma.14 <- function() assertThat(lgamma(0.01), identicalTo(4.59947987804202, tol = 0.000100))
test.lgamma.15 <- function() assertThat(lgamma(0.1), identicalTo(2.25271265173421, tol = 0.000100))
test.lgamma.16 <- function() assertThat(lgamma(1), identicalTo(0))
test.lgamma.17 <- function() assertThat(lgamma(1.5), identicalTo(-0.120782237635245, tol = 0.000100))
test.lgamma.18 <- function() assertThat(lgamma(2), identicalTo(0))
test.lgamma.19 <- function() assertThat(lgamma(2.5), identicalTo(0.284682870472919, tol = 0.000100))
test.lgamma.20 <- function() assertThat(lgamma(4), identicalTo(1.79175946922805, tol = 0.000100))
test.lgamma.21 <- function() assertThat(lgamma(10), identicalTo(12.8018274800815, tol = 0.000100))
test.lgamma.22 <- function() assertThat(lgamma(100), identicalTo(359.134205369575, tol = 0.000100))
test.lgamma.23 <- function() assertThat(lgamma(0.785398), identicalTo(0.166398206927829, tol = 0.000100))
test.lgamma.24 <- function() assertThat(lgamma(1.5708), identicalTo(-0.115903431045609, tol = 0.000100))
test.lgamma.25 <- function() assertThat(lgamma(3.14159), identicalTo(0.827691999201495, tol = 0.000100))
test.lgamma.26 <- function() assertThat(lgamma(6.28319), identicalTo(5.27779690742411, tol = 0.000100))
test.lgamma.27 <- function() assertThat(lgamma(NULL), throwsError())
test.lgamma.28 <- function() assertThat(lgamma(c(0.01, 0.1, 1, 1.5)), identicalTo(c(4.59947987804202, 2.25271265173421, 0, -0.120782237635245), tol = 0.000100))
test.lgamma.29 <- function() assertThat(lgamma(integer(0)), identicalTo(numeric(0)))
test.lgamma.30 <- function() assertThat(lgamma(numeric(0)), identicalTo(numeric(0)))
test.lgamma.31 <- function() assertThat(lgamma(NaN), identicalTo(NaN))
test.lgamma.32 <- function() assertThat(lgamma(NA_real_), identicalTo(NA_real_))
test.lgamma.33 <- function() assertThat(lgamma(Inf), identicalTo(Inf))
test.lgamma.34 <- function() assertThat(lgamma(-Inf), identicalTo(Inf))
test.lgamma.35 <- function() assertThat(lgamma(c(1L, 4L)), identicalTo(c(0, 1.79175946922805), tol = 0.000100))
test.lgamma.36 <- function() assertThat(lgamma(structure(1, class = "foo")), identicalTo(41))
test.lgamma.37 <- function() assertThat(lgamma(structure(1, class = "bar")), identicalTo(44))
test.lgamma.38 <- function() assertThat(lgamma(structure(list("a"), class = "foo")), identicalTo(41))
test.lgamma.39 <- function() assertThat(lgamma(structure(list("b"), class = "bar")), identicalTo(44))
test.lgamma.40 <- function() assertThat(lgamma(structure(c(1, 2, 3), .Names = c("a", "b", "c"))), identicalTo(structure(c(0, 0, 0.693147180559945), .Names = c("a", "b", "c")), tol = 0.000100))
test.lgamma.41 <- function() assertThat(lgamma(structure(c(1, 2), .Names = c("x", ""))), identicalTo(structure(c(0, 0), .Names = c("x", ""))))
test.lgamma.42 <- function() assertThat(lgamma(structure(1:12, .Dim = 3:4)), identicalTo(structure(c(0, 0, 0.693147180559945, 1.79175946922805, 3.17805383034795, 4.78749174278205, 6.5792512120101, 8.52516136106541, 10.6046029027453, 12.8018274800815, 15.1044125730755, 17.5023078458739), .Dim = 3:4), tol = 0.000100))
test.lgamma.43 <- function() assertThat(lgamma(structure(0, rando.attr = 4L)), identicalTo(structure(Inf, rando.attr = 4L)))
test.lgamma.44 <- function() assertThat(lgamma(structure(0, class = "zinga")), identicalTo(structure(Inf, class = "zinga")))
