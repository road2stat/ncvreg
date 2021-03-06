\name{fir}
\alias{fir}
\title{False inclusion rates for ncvreg}
\description{Estimates false inclusion rates (FIR) for penalized
  regression models.}
\usage{
fir(fit)
}
\arguments{
  \item{fit}{An \code{ncvreg} or \code{ncvsurv} object.}
  }
\details{
  The function estimates the false inclusion rate (FIR) for a penalized
  regression model.  The estimate tends to be accurate in most settings,
  but will be slightly conservative if predictors are highly correlated.
  For an alternative way of estimating the false inclusion rate,
  typically more accurate in highly correlated cases,  see
  \code{\link{perm.ncvreg}}.}
\value{
  An object with S3 class \code{fir} inheriting from \code{data.frame} and
  containing:
  \item{EF}{The number of variables selected at each value of
    \code{lambda}, averaged over the permutation fits.}
  \item{S}{The actual number of selected variables for the non-permuted
    data.}
  \item{FIR}{The estimated false inclusion rate (\code{EF/S}).}
  }
%\references{None yet}
\author{Patrick Breheny <patrick-breheny@uiowa.edu>, with contributions from
  Ryan Miller <ryan-e-miller@uiowa.edu>}
\seealso{\code{\link{ncvreg}}, \code{\link{ncvsurv}}, \code{\link{plot.fir}},
  \code{\link{perm.ncvreg}}}
\examples{

#### Linear regression -----------------------------
data(prostate)
X <- as.matrix(prostate[,1:8])
y <- prostate$lpsa
fit <- ncvreg(X, y)

obj <- fir(fit)
obj[1:10,]

# Comparison with perm.ncvreg
par(mfrow=c(2,2))
plot(obj)
plot(obj, type="EF")
pmfit <- perm.ncvreg(X, y)
plot(pmfit)
plot(pmfit, type="EF")
# Note that fir() is more conservative

#### Logistic regression ---------------------------
data(heart)
X <- as.matrix(heart[,1:9])
y <- heart$chd
fit <- ncvreg(X, y, family="binomial")
obj <- fir(fit)
head(obj)
plot(obj)
plot(obj, type="EF")

#### Cox regression --------------------------------
data(Lung)
X <- Lung$X
y <- Lung$y
fit <- ncvsurv(X, y)
obj <- fir(fit)
head(obj)
plot(obj)
plot(obj, type="EF")
}
