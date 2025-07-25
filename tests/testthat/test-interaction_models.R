test_that("interaction_models returns a list with expected names", {
  library(gtregression)
  library(dplyr)
  data("PimaIndiansDiabetes2", package = "mlbench")

  pima_data <- PimaIndiansDiabetes2 |>
    mutate(diabetes = ifelse(diabetes == "pos", 1, 0)) |>
    mutate(
      bmi = factor(
        case_when(
          mass < 25 ~ "Normal",
          mass >= 25 & mass < 30 ~ "Overweight",
          mass >= 30 ~ "Obese"
        ),
        levels = c("Normal", "Overweight", "Obese")
      ),
      age_cat = factor(
        case_when(
          age < 30 ~ "Young",
          age >= 30 & age < 50 ~ "Middle-aged",
          age >= 50 ~ "Older"
        ),
        levels = c("Young", "Middle-aged", "Older")
      ),
      glucose_cat = factor(
        case_when(
          glucose < 140 ~ "Normal",
          glucose >= 140 ~ "High"
        ),
        levels = c("Normal", "High")
      )
    )

  result <- interaction_models(
    data = pima_data,
    outcome = "diabetes",
    exposure = "age_cat",
    effect_modifier = "glucose_cat",
    approach = "logit"
  )

  expect_type(result, "list")
  expect_named(result, c("model_no_interaction",
                         "model_with_interaction", "p_value", "test"))
})

test_that("interaction_models handles robpoisson approach", {
  library(gtregression)
  library(dplyr)
  data("PimaIndiansDiabetes2", package = "mlbench")

  pima_data <- PimaIndiansDiabetes2 |>
    mutate(diabetes = ifelse(diabetes == "pos", 1, 0)) |>
    mutate(
      age_cat = factor(case_when(
        age < 30 ~ "Young",
        age >= 30 & age < 50 ~ "Middle-aged",
        age >= 50 ~ "Older"
      )),
      glucose_cat = factor(case_when(
        glucose < 140 ~ "Normal",
        glucose >= 140 ~ "High"
      ))
    )

  result <- interaction_models(
    data = pima_data,
    outcome = "diabetes",
    exposure = "age_cat",
    effect_modifier = "glucose_cat",
    approach = "robpoisson"
  )

  expect_type(result, "list")
  expect_named(result, c("model_no_interaction",
                         "model_with_interaction", "p_value", "test"))
})

test_that("interaction_models errors with invalid approach", {
  library(gtregression)
  library(dplyr)
  data("PimaIndiansDiabetes2", package = "mlbench")

  pima_data <- PimaIndiansDiabetes2 |>
    mutate(diabetes = ifelse(diabetes == "pos", 1, 0)) |>
    mutate(
      age_cat = factor(case_when(
        age < 30 ~ "Young",
        age >= 30 & age < 50 ~ "Middle-aged",
        age >= 50 ~ "Older"
      )),
      glucose_cat = factor(case_when(
        glucose < 140 ~ "Normal",
        glucose >= 140 ~ "High"
      ))
    )

  expect_error(
    interaction_models(
      data = pima_data,
      outcome = "diabetes",
      exposure = "age_cat",
      effect_modifier = "glucose_cat",
      approach = "invalid"
    ),
    "invalid  is not a valid approach for interaction_models"
  )
})
