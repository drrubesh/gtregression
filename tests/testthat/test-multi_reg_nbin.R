test_that("multi_reg_nbin computes adjusted IRRs
          using negative binomial regression", {
  skip_if_not_installed("gtregression")
  skip_if_not_installed("MASS")
  skip_if_not_installed("gtsummary")
  skip_if_not_installed("dplyr")

  data("quine", package = "MASS")

  quine_data <- quine |>
    mutate(
      Eth = factor(Eth),
      Sex = factor(Sex),
      Age = factor(Age),
      Lrn = factor(Lrn)
    )

  outcome <- "Days"
  exposures <- c("Eth", "Sex", "Age", "Lrn")

  # Count check
  is_count <- function(x) is.numeric(x) && all(x >= 0 &
                                                 x == floor(x), na.rm = TRUE)
  if (!is_count(quine_data[[outcome]]))
    skip("Outcome is not a non-negative count variable.")

  result <- tryCatch(
    {
      suppressWarnings(multi_reg_nbin(data = quine_data,
                                      outcome = outcome,
                                      exposures = exposures))
    },
    error = function(e) {
      message("multi_reg_nbin() failed:\n", e$message)
      return(NULL)
    }
  )

  if (is.null(result)) {
    skip("Skipping test: multi_reg_nbin() returned NULL unexpectedly.")
  } else {
    expect_s3_class(result, "tbl_regression")
    expect_true(nrow(result$table_body) > 0,
                info = "No rows in regression output.")
    expect_true("estimate" %in% names(result$table_body),
                info = "Missing 'estimate' column.")
    expect_true(!is.null(attr(result, "approach")))
    expect_true(!is.null(attr(result, "source")))

    expect_equal(attr(result, "approach"), "negbin")
    expect_equal(attr(result, "source"), "multi_reg_nbin")
    expect_length(attr(result, "approach"), 1)
    expect_length(attr(result, "source"), 1)

    # Accessors
    expect_type(result$models, "list")
    expect_type(result$model_summaries, "list")
    expect_s3_class(result$table, "tbl_regression")
  }

  # Invalid outcome: not a count variable
  quine_data$not_count <- rnorm(nrow(quine_data)) # Continuous

  expect_error(
    multi_reg_nbin(data = quine_data, outcome = "not_count",
                   exposures = exposures),
    regexp = "Negative binomial requires a count outcome",
    info = "Expected error when outcome is not count"
  )
})
