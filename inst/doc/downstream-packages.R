## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(collapse = TRUE, comment = "#>")
library(form.model)

## -----------------------------------------------------------------------------
path <- form_resource("examples/survey-form.yaml", "form.model")
stopifnot(file.exists(path))
m <- select_form_model(path, "survey", "2026.1")
form_references(m)

## -----------------------------------------------------------------------------
form_fields(m, sheet = "Observations")
form_layout(m, id = "Observations")
form_field(m, id = "Metadata.submission")[c("row", "column")]
form_references(m)

