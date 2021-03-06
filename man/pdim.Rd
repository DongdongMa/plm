\name{pdim}
\alias{pdim}
\alias{pdim.data.frame}
\alias{pdim.pdata.frame}
\alias{pdim.pseries}
\alias{pdim.panelmodel}
\alias{pdim.pgmm}
\alias{pdim.default}
\alias{print.pdim}

\title{Check for the Dimensions of the Panel}

\description{This function checks the number of individuals and time
  observations in the panel and whether it is balanced or not.}

\usage{
pdim(x, \dots)
\method{pdim}{data.frame}(x, index = NULL, \dots)
\method{pdim}{panelmodel}(x, \dots)
\method{pdim}{pseries}(x, \dots)
\method{pdim}{pdata.frame}(x, \dots)
\method{pdim}{pgmm}(x, \dots)
}

\arguments{
 \item{x}{a \code{data.frame}, a \code{pdata.frame}, a \code{pseries}, a \code{panelmodel}, or a \code{pgmm} object,}
 \item{index}{see \code{\link{pdata.frame}},}
 \item{\dots}{further arguments.}
}

\value{
 An object of class \code{pdim} containing the following elements:

 \item{nT}{a list containing \code{n}, the number of individuals, \code{T},
  the number of time observations, \code{N} the total number of observations,}
 \item{Tint}{a list containing two vectors (of type integer): \code{Ti} gives the
  number of observations for each individual and \code{nt} gives
  the number of individuals observed for each period,}
 \item{balanced}{a logical value: \code{TRUE} for a balanced panel,
  \code{FALSE} for an unbalanced panel,}
 \item{panel.names}{a list of character vectors: \code{id.names}
  contains the names of each individual and \code{time.names}
  contains the names of each period.}
}

\note{Calling \code{pdim} on an estimated \code{panelmodel} object and on the corresponding \code{(p)data.frame}
  used for this estimation does not necessarily yield the same result. When called on an estimated \code{panelmodel},
  the number of observations (individual, time) actually used for model estimation are taken into account.
  When called on a \code{(p)data.frame}, the rows in the \code{(p)data.frame} are considered, disregarding any
  NA values in the dependent or independent variable(s) which would be dropped during model estimation.
}

\details{
\code{pdim} is called by the estimation functions and can be also used stand-alone.
}

\author{Yves Croissant}

\seealso{
 \code{\link{is.pbalanced}} to just determine balancedness of data (slightly faster than \code{pdim}),\cr
 \code{\link{punbalancedness}} for measures of unbalancedness,\cr
 \code{\link{nobs}}, \code{\link{pdata.frame}},\cr
 \code{\link{pvar}} to check for each variable if it varies cross-sectionally and over time.
}

\examples{
# There are 595 individuals
data("Wages", package = "plm")
pdim(Wages, 595)

# Gasoline contains two variables which are individual and time indexes
# and are the first two variables
data("Gasoline", package="plm")
pdim(Gasoline)

# Hedonic is an unbalanced panel, townid is the individual index
data("Hedonic", package = "plm")
pdim(Hedonic, "townid")

# An example of the panelmodel method
data("Produc", package = "plm")
z <- plm(log(gsp)~log(pcap)+log(pc)+log(emp)+unemp,data=Produc,
         model="random", subset = gsp > 5000)
pdim(z)
}

\keyword{attribute}
