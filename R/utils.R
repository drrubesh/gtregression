#' @importFrom stats AIC BIC anova as.formula binomial coef cooks.distance
#' @importFrom stats deviance glm glm.control lm logLik na.omit nobs poisson
#' @importFrom stats predict residuals shapiro.test
#' @importFrom utils globalVariables
#' @importFrom dplyr bind_rows case_when filter mutate
#' @importFrom tibble tibble
#' @importFrom broom.helpers tidy_plus_plus tidy_add_reference_rows
#' @importFrom utils head

# Prevent global variable warnings
utils::globalVariables(c(
  ".data",
  "reference_row", "variable", "label_clean", "header_order", "row_id",
  "estimate", "conf.low", "conf.high", "approach", "stat_n"
))
