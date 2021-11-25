data "template_file" "environment_variables_rails" {
  template = <<EOF
  [
    { "name": "RAILS_ENV", "value": "${var.env}" }
  ]
  EOF
}
