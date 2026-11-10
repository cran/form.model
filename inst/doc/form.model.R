## ----setup, include=FALSE-----------------------------------------------------
# Format the rendered R output consistently.
knitr::opts_chunk$set(collapse = TRUE, comment = "#>")
library(form.model)

## ----example-downloads, echo=FALSE, results="asis"----------------------------
# Use relative downloads on the website and installed resources in the package guide.
if (identical(Sys.getenv("IN_PKGDOWN"), "true")) {
  # Render links relative to the website article.
  cat("- [Form model — form.yaml](../examples/survey/form.yaml)\n- [Populated form — form.xlsx](../examples/survey/form.xlsx)\n- [Empty form — form-empty.xlsx](../examples/survey/form-empty.xlsx)\n")
} else {
  # Explain where the installed package keeps the example files.
  cat("Find these files with `system.file(\"examples\", \"survey\", package = \"form.model\")`.\n")
}

## -----------------------------------------------------------------------------
library(form.model)
# Load the bundled survey form model.
model_definition <- read_form_model("examples/survey/form.yaml", "form.model")
# Display its identity and worksheet summary.
model_definition

## -----------------------------------------------------------------------------
# Select the survey definition with the exact requested version.
select_form_model(
  "examples/survey/form.yaml", "survey", "2026.2",
  package = "form.model"
)

## -----------------------------------------------------------------------------
# Inspect the top-level form model properties.
names(model_definition)

## -----------------------------------------------------------------------------
# List the worksheets in declaration order.
names(model_definition$sheets)
# List the metadata fields in declaration order.
names(model_definition$sheets$Metadata$fields)
# Inspect the submission identifier's requiredness, cell and type.
model_definition$sheets$Metadata$fields$submission[c("mandatory", "location", "type")]

## -----------------------------------------------------------------------------
# Inspect the observation unit's allowed values and required-field condition.
form_field(model_definition, "Observations.unit")[c("enum", "required_field")]
# Inspect the station's reference binding.
form_field(model_definition, "Observations.station")$reference
# Locate the first observation row in the form.
form_layout(model_definition, "Observations")$start_row

# Check the structure and consistency of the definition.
check_form_model(form_definition(model_definition))

## -----------------------------------------------------------------------------
# Copy the definition for an invalid-reference example.
invalid_definition <- form_definition(model_definition)
# Point the station binding at an undeclared table.
invalid_definition$sheets$Observations$fields$station$reference$table <- "missing"

# Check the changed definition without throwing an error.
definition_check <- check_form_model(invalid_definition, resource = "my-definition.yaml")
# Display the reported form model errors.
definition_check$diagnostics
# Confirm that the changed definition was rejected.
stopifnot(!definition_check$valid)

## -----------------------------------------------------------------------------
# Capture the error raised when constructing the invalid form model.
definition_error <- tryCatch(
  as_form_model(invalid_definition, "my-definition.yaml"), model_form_error = identity)
# Inspect the property that caused the error.
definition_error$path
# Inspect the full set of definition errors.
definition_error$diagnostics

## ----api-link, echo=FALSE, results="asis"-------------------------------------
# Link to the website API index or explain how to open installed function help.
if (identical(Sys.getenv("IN_PKGDOWN"), "true")) {
  # Render the relative website link.
  cat("- [Function reference](../reference/index.html): API details.\n")
} else {
  # Point readers to the installed help index.
  cat("Open the function reference with `help(package = \"form.model\")`.\n")
}

