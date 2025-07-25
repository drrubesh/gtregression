% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/datasets.R
\docType{data}
\name{data_infertility}
\alias{data_infertility}
\title{Infertility Matched Case-Control Study}
\format{
A data frame with 248 observations and 8 variables:
\describe{
  \item{education}{Education level (0 = 0–5 years, 1 = 6–11 years,
  2 = 12+ years)}
  \item{age}{Age in years}
  \item{parity}{Number of prior pregnancies}
  \item{induced}{Number of induced abortions}
  \item{case}{Infertility case status (1 = case, 0 = control)}
  \item{spontaneous}{Number of spontaneous abortions}
  \item{stratum}{Matched set ID}
  \item{pooled.stratum}{Pooled stratum ID used for conditional regression}
}
}
\source{
\url{https://stat.ethz.ch/R-manual/R-devel/library/datasets/html/infert.html}
}
\usage{
data_infertility
}
\description{
investigating the relationship between infertility and abortions.
}
\keyword{datasets}
