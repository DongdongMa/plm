\name{pcdtest}
\alias{pcdtest}
\alias{pcdtest.formula}
\alias{pcdtest.panelmodel}
\alias{pcdtest.pseries}
\title{Tests of cross-section dependence for panel models}

\description{
 Pesaran's CD or Breusch--Pagan's LM (local or global) tests for cross sectional dependence in panel models
}

\usage{
pcdtest(x, \dots)
\method{pcdtest}{formula}(x, data, index = NULL, model = NULL,
                          test = c("cd", "sclm", "lm", "rho", "absrho"),
                          w = NULL, \dots)
\method{pcdtest}{panelmodel}(x, test = c("cd", "sclm", "lm", "rho", "absrho"),
                             w = NULL, \dots)
\method{pcdtest}{pseries}(x, test = c("cd", "sclm", "lm", "rho", "absrho"),
                             w = NULL, \dots)
                          
}

\arguments{
 \item{x}{an object of class \code{formula}, \code{panelmodel}, or \code{pseries} 
          (depending on the respective interface) describing the model to be tested}
 \item{data}{a \code{data.frame}}
 \item{index}{an optional numerical index, in case \code{data} has to be formatted by \code{plm.data}}
 \item{model}{an optional character string indicating which type of model to estimate;
 if left to \code{NULL}, the original heterogeneous specification of Pesaran is used}
 \item{test}{the type of test statistic to be returned. One of 
  \itemize{
   \item \code{"cd"} for Pesaran's CD statistic,
    \item \code{"lm"} for Breusch and Pagan's original LM statistic,
    \item \code{"sclm"} for the scaled version of Breusch and Pagan's LM statistic, or
    \item \code{"rho"} for the average correlation coefficient,
    \item \code{"absrho"} for the average absolute correlation coefficient,}}
 \item{w}{either \code{NULL} (default) for the global tests or - for the local versions of the statistics - a \code{n x n} \code{matrix} describing proximity between individuals, with \eqn{w_ij = a} where \eqn{a} is any number such that \code{as.logical(a)==TRUE}, if \eqn{i,j} are
 neighbours, \eqn{0} or any number \eqn{b} such that \code{as.logical(b)==FALSE} elsewhere. Only the lower triangular part (without diagonal) of \code{w} after coercing by \code{as.logical()} is evaluated for neighbouring information (but \code{w} can be symmetric). See also \bold{Details} and \bold{Examples}.}
 \item{\dots}{further arguments to be passed on to \code{plm}, such as e.g. \code{effect} or \code{random.method}}
}

\value{
An object of class \code{"htest"}.
}

\details{
 These tests are originally meant to use the residuals of separate estimation of one time--series regression for each cross-sectional unit in order to check for cross--sectional dependence. If a different model specification (\code{within}, \code{random}, \ldots) is assumed consistent, one can resort to its residuals for testing (which is common, e.g., when the time dimension's length is insufficient for estimating the heterogeneous model). If the time dimension is insufficient and \code{model=NULL}, the function defaults to estimation of a \code{within} model and issues a warning. The main argument of this function may be either a model of class \code{panelmodel} or a \code{formula} and \code{dataframe}; in the second case, unless \code{model} is set to \code{NULL}, all usual parameters relative to the estimation of a \code{plm} model may be passed on. The test is compatible with any consistent \code{panelmodel} for the data at hand, with any specification of \code{effect}. E.g., specifying \code{effect=''time''} or \code{effect=''twoways''} allows to test for residual cross-sectional dependence after the introduction of time fixed
 effects to account for common shocks. 
 
 A \emph{local} version of either test can be computed by supplying a proximity matrix (elements coercible to \code{logical}) with argument \code{w} which provides information on whether any pair of individuals are neighbours or not. If \code{w} is supplied, only neighbouring pairs will be used in computing the test; else, \code{w} will default to \code{NULL} and all observations will be used. The matrix need not be binary, so commonly used ``row--standardized'' matrices can be employed as well. \code{nb} objects from \pkg{spdep} must instead be transformed into matrices by \pkg{spdep}'s function \code{nb2mat} before using. 
 
 The methods implemented are suitable also for unbalanced panels.
 
 Pesaran's CD test (\code{test="cd"}), Breusch and Pagan's LM test (\code{test="lm"}), and it's scaled version (\code{test="sclm"}) are all described in Pesaran (2004) (and complemented by Pesaran (2015)). Breusch/Pagan (1980) is the original source for the LM test.
  
 The test on a \code{pseries} is the same as a test on a pooled regression model of that variable on a constant, i.e. 
 \code{pcdtest(some_pseries)} is equivalent to \code{pcdtest(plm(some_var ~ 1, data = some_pdata.frame, model = "pooling")} and also
 equivalent to \code{pcdtest(some_var ~ 1, data = some_data)}, where \code{some_var} is the variable name in the data which 
 corresponds to \code{some_pseries}.
}

\references{
 Breusch, T.S. and A.R. Pagan (1980), The Lagrange multiplier test and its applications to model specification in econometrics, \emph{Review of Economic Studies}, \bold{47}(1), pp. 239--253.

 Pesaran, M.H. (2004), General Diagnostic Tests for Cross Section Dependence in Panels, \emph{CESifo} Working Paper 1229.
 
 Pesaran, M.H. (2015), Testing Weak Cross--Sectional Dependence in Large Panels, \emph{Econometric Reviews}, \bold{34}(6-10), pp. 1089--1117.
}

\examples{
data(Grunfeld, package = "plm")
## test on heterogeneous model (separate time series regressions)
pcdtest(inv ~ value + capital, data = Grunfeld,
        index = c("firm", "year"))

## test on two-way fixed effects homogeneous model
pcdtest(inv ~ value + capital, data = Grunfeld, model = "within",
        effect = "twoways", index = c("firm", "year"))

## test on panelmodel object
g <- plm(inv ~ value + capital, data = Grunfeld, index = c("firm", "year"))
pcdtest(g)

## scaled LM test
pcdtest(g, test = "sclm")

## test on pseries
pGrunfeld <- pdata.frame(Grunfeld)
pcdtest(pGrunfeld$value)

## local test
## define neighbours for individual 2: 1, 3, 4, 5 in lower triangular matrix
w <- matrix(0, ncol= 10, nrow=10)
w[2,1] <- w[3,2] <- w[4,2] <- w[5,2] <- 1
pcdtest(g, w = w)
}

\keyword{htest}
