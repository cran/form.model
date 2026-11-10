## ----setup, include=FALSE-----------------------------------------------------
# Format the rendered R output consistently.
knitr::opts_chunk$set(collapse = TRUE, comment = "#>")
library(form.model)

## -----------------------------------------------------------------------------
# Locate the installed survey definition.
model_resource_path <- form_resource("examples/survey/form.yaml", "form.model")
# Confirm that the installed resource exists.
stopifnot(file.exists(model_resource_path))
# Load the definition with the exact survey identity and version.
model_definition <- select_form_model(model_resource_path, "survey", "2026.2")
# Inspect its catalogue and table requirements.
form_references(model_definition)

## -----------------------------------------------------------------------------
# Inspect observation fields in workbook column order.
form_fields(model_definition, sheet = "Observations")
# Inspect the observation table layout.
form_layout(model_definition, id = "Observations")
# Locate the submission identifier's row and column.
form_field(model_definition, id = "Metadata.submission")[c("row", "column")]

