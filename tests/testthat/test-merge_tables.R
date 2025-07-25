test_that("merge_tables works with tbl_summary and tbl_regression", {
  skip_if_not_installed("gtregression")
  skip_if_not_installed("gtsummary")
  skip_if_not_installed("tibble")

  data("data_PimaIndiansDiabetes", package = "gtregression")
  Pima <- data_PimaIndiansDiabetes |>
    mutate(diabetes = ifelse(diabetes == "pos", 1, 0)) |> # Convert outcome to numeric b                                                                                                                                                                                                                                                                     inary
    mutate(bmi = case_when(
      mass < 25 ~ "Normal",
      mass >= 25 & mass < 30 ~ "Overweight",
      mass >= 30 ~ "Obese",
      TRUE ~ NA_character_),
      bmi = factor(bmi, levels = c("Normal", "Overweight", "Obese")),
      age_cat = case_when(
        age < 30 ~ "Young",
        age >= 30 & age < 50 ~ "Middle-aged",
        age >= 50 ~ "Older"),
      age_cat = factor(age_cat, levels = c("Young", "Middle-aged", "Older")),
      npreg_cat = ifelse(pregnant > 2, "High parity", "Low parity"),
      npreg_cat = factor(npreg_cat, levels = c("Low parity", "High parity")),
      glucose_cat= case_when(glucose<=140~ "Normal", glucose>140~"High"),
      glucose_cat= factor(glucose_cat, levels = c("Normal", "High")),
      bp_cat = case_when(
        pressure < 80 ~ "Normal",
        pressure >= 80 ~ "High"
      ),
      bp_cat= factor(bp_cat, levels = c("Normal", "High")),
      triceps_cat = case_when(
        triceps < 23 ~ "Normal",
        triceps >= 23 ~ "High"
      ),
      triceps_cat= factor(triceps_cat, levels = c("Normal", "High")),
      insulin_cat = case_when(
        insulin < 30 ~ "Low",
        insulin >= 30 & insulin < 150 ~ "Normal",
        insulin >= 150 ~ "High"
      ),
      insulin_cat = factor(insulin_cat, levels = c("Low", "Normal", "High"))
    ) |>
    mutate(
      dpf_cat = case_when(
        pedigree <= 0.2 ~ "Low Genetic Risk",
        pedigree > 0.2 & pedigree <= 0.5 ~ "Moderate Genetic Risk",
        pedigree > 0.5 ~ "High Genetic Risk"
      )
    ) |>
    mutate(dpf_cat = factor(dpf_cat, levels = c("Low Genetic Risk", "Moderate Genetic Risk", "High Genetic Risk"))) |>
    mutate(diabetes_cat= case_when(diabetes== 1~ "Diabetes positive", TRUE~ "Diabetes negative")) |>
    mutate(diabetes_cat= factor(diabetes_cat, levels = c("Diabetes negative","Diabetes positive" )))

  # Create descriptive table
  desc_tbl <- Pima |>
    dplyr::select(age_cat, npreg_cat, bmi, glucose_cat, bp_cat, triceps_cat, diabetes_cat, insulin_cat, dpf_cat) |>
    tbl_summary(by = diabetes_cat)

  # Create univariate regression table
  uni_tbl <- gtregression::uni_reg(
    data = Pima,
    outcome = "diabetes",
    exposures = c("age", "mass"),
    approach= "logit"
  )

  # Create multivariable regression table
  multi_tbl <- gtregression::multi_reg(
    data = Pima,
    outcome = "diabetes",
    exposures = c("age", "mass"),
    approach= "logit"
  )

  # Test merge with auto spanners
  merged1 <- merge_tables(desc_tbl, uni_tbl)
  expect_s3_class(merged1, "gtsummary")
  expect_equal(length(merged1$tbls), 2)

  # Test merge with custom spanners
  merged2 <- merge_tables(uni_tbl, multi_tbl)
  expect_s3_class(merged2, "gtsummary")
  expect_equal(length(merged2$tbls), 2)

  # Test merge with 3 tables
  merged3 <- merge_tables(desc_tbl, uni_tbl, multi_tbl)
  expect_s3_class(merged3, "gtsummary")
  expect_equal(length(merged3$tbls), 3)

  # Error if less than 2 tables
  expect_error(merge_tables(desc_tbl), "At least two gtsummary tables")

  # Error if mismatched spanners
  expect_error(merge_tables(uni_tbl, multi_tbl, spanners = "Only one"), "must match the number of tables")
})
test_that("merge_tables handles invalid inputs", {
  skip_if_not_installed("gtsummary")

  # Test with non-gtsummary object
  expect_error(merge_tables(data.frame(x = 1:5)),
               "At least two gtsummary tables are required to merge.")

  # Test with single table
  expect_error(merge_tables(gtsummary::tbl_summary(mtcars)), "At least two gtsummary tables are required")
})
