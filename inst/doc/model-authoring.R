## ----example-download, echo=FALSE, results="asis"-----------------------------
# Offer a relative website download or the installed resource path.
if (identical(Sys.getenv("IN_PKGDOWN"), "true")) {
  # Render the relative download link.
  cat("[Download the survey YAML](../examples/survey/form.yaml)\n")
} else {
  # Point readers to the bundled YAML definition.
  cat("Find the YAML with `form_resource(\"examples/survey/form.yaml\", \"form.model\")`.\n")
}

## ----results='asis', echo=FALSE-----------------------------------------------
# Display the bundled definition as a YAML example.
cat("```yaml\n", paste(readLines(form.model::form_resource("examples/survey/form.yaml", "form.model")), collapse="\n"), "\n```\n", sep="")

