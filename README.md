
# gtregression

`gtregression` is an R package that simplifies regression modeling and
generates publication-ready tables using the `gtsummary` ecosystem. It
supports a variety of regression approaches with built-in tools for
model diagnostics, selection, and confounder identification—all designed
to provide beginner and intermediate R users with clean, interpretable
output.

This package was created with the aim of empowering R users in low- and
middle-income countries (LMICs) by offering a simpler and more
accessible coding experience. We sincerely thank the authors and
contributors of foundational R packages such as `gtsummary`, `MASS`,
`RISKS`, `dplyr`, and others—without whom this project would not have
been possible.

## Vision

At its core, `gtregression` is more than just a statistical tool—it is a
commitment to open access, simplicity, and inclusivity in health data
science. Our team is driven by the vision of empowering researchers,
students, and public health professionals in LMICs through
user-friendly, well-documented tools that minimize coding burden and
maximize interpretability.

We strongly believe in the democratization of data science, and aim to
promote the use of open-source resources for impactful and equitable
research across the globe.

## Features

- Supports multiple regression types:  
  Logistic (logit)  
  Log-binomial  
  Poisson / Robust Poisson  
  Negative Binomial  
  Linear Regression

- Univariable and multivariable regression  

- Confounder identification using crude, adjusted, and stratified
  estimates  

- Stepwise model selection with AIC/BIC/adjusted R²  

- Stratified regression functions  

- Integration with `gtsummary` for formatted tables  

- Built-in healthcare datasets for training: `PimaIndiansDiabetes2`,
  `birthwt`, `epil`

## Installation

``` r
# Install from GitHub (requires devtools)
devtools::install_github("drrubesh/gtregression")
```

``` r
## Quick Start
library(gtregression)

# Logistic regression example
data(PimaIndiansDiabetes2)
multi_reg(
  data = PimaIndiansDiabetes2,
  outcome = "diabetes",
  exposures = c("age", "mass", "glucose"),
  approach = "logit"
)
```

``` r
# Negative binomial regression example
data(epil)
multi_reg_nbin(
  data = epil,
  outcome = "y",
  exposures = c("trt", "base", "age")
)
```

## Functions

| Function Name | Description |
|----|----|
| `uni_reg()` | Univariable regression with multiple approaches |
| `multi_reg()` | Multivariable regression |
| `select_models()` | Stepwise model selection with AIC/BIC |
| `identify_confounder()` | Confounder evaluation using stratified methods |
| `check_convergence()` | A quick check to test model convergence |
| `interaction_models()` | Compare models with and without interactions |
| `stratified_uni_reg()` | Stratified univariable regression |
| `stratified_multi_reg()` | Stratified multivariable regression |
| `uni_reg_nbin()` | Univariable negative binomial regression |
| `multi_reg_nbin()` | Multivariable negative binomial regression |
| `stratified_uni_nbin()` | Stratified univariable negative binomial regression |
| `stratified_multi_nbin()` | Stratified multivariable negative binomial regression |

## Contributing

We welcome issues, feature requests, and contributions.

Fork the repository

Create a new branch: git checkout -b feature/my-feature

Commit your changes: git commit -m “Add feature”

Push to GitHub: git push origin feature/my-feature

Open a Pull Request

## Authors

Rubeshkumar Polani Chandrasekar – @drrubesh

Yuvaraj Krishnamoorthy

Marie Gilbert Majella

## License

MIT License. See LICENSE for details.
