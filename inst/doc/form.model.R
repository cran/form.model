## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(collapse = TRUE, comment = "#>")
library(form.model)

## -----------------------------------------------------------------------------
library(form.model)
directory <- system.file("examples", package = "form.model")
m <- load_form_model("survey", directory)
m

## -----------------------------------------------------------------------------
names(m)

## -----------------------------------------------------------------------------
names(m$sheets)
names(m$sheets$Metadata$fields)
m$sheets$Metadata$fields$submission[c("mandatory", "location", "type")]

## -----------------------------------------------------------------------------
d <- form_definition(m)
d$sheets[[2]]$fields[[1]]$reference <- "missing"
result <- check_form_model(d, resource = "my-definition.yaml")
result$diagnostics
stopifnot(!result$valid)

## -----------------------------------------------------------------------------
error <- tryCatch(as_form_model(d, "my-definition.yaml"), model_form_error = identity)
error$path
error$diagnostics

