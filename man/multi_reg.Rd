% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/multi_reg.R
\name{multi_reg}
\alias{multi_reg}
\title{Multivariable regression (Adjusted Odds, Risk, or Rate Ratios)}
\usage{
multi_reg(data, outcome, exposures, approach = "logit", summary = FALSE)
}
\arguments{
\item{data}{A data frame containing the variables.}

\item{outcome}{The name of the outcome variable (binary, count, or continuous).}

\item{exposures}{A vector of predictor variables.}

\item{approach}{Modeling approach to use. One of:
`"logit"` (OR), `"log-binomial"` (RR), `"poisson"` (IRR),
`"robpoisson"` (RR), `"margstd_boot"` (RR), `"margstd_delta"` (RR), `"linear"` (Beta coefficients)}

\item{summary}{Logical; if `TRUE`, prints model summary after fitting. Default is `FALSE`.}
}
\value{
A `gtsummary::tbl_regression` object with adjusted effect estimates.
}
\description{
Performs multivariable regression with multiple exposures on a binary, count, or continuous outcome.
Depending on `approach`, returns either Adjusted Odds Ratios (OR), Risk Ratios (RR), Incidence Rate Ratios (IRR), or Beta coefficients.
}
