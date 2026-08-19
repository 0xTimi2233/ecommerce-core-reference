#!/usr/bin/env ruby
# frozen_string_literal: true

ROOT = File.expand_path("..", __dir__)
errors = []

required_pr_sections = [
  "## Summary",
  "## Stage and boundary",
  "## Evidence",
  "## Review focus",
  "## Residual risk"
].freeze
pr_template = File.read(File.join(ROOT, ".github/pull_request_template.md"))
required_pr_sections.each do |heading|
  errors << ".github/pull_request_template.md: missing #{heading}" unless pr_template.include?(heading)
end

expected_form_text = {
  ".github/ISSUE_TEMPLATE/01-artifact-spec.yml" => "Do not use it to deliver implementation.",
  ".github/ISSUE_TEMPLATE/02-feature.yml" => "not an implementation slice or integration proof.",
  ".github/ISSUE_TEMPLATE/03-vertical-slice.yml" => "Do not use this form for broad planning or final composition.",
  ".github/ISSUE_TEMPLATE/04-final-integration.yml" => "must not add a new domain rule."
}.freeze
expected_form_text.each do |relative_path, boundary_text|
  content = File.read(File.join(ROOT, relative_path))
  errors << "#{relative_path}: missing explicit boundary statement" unless content.include?(boundary_text)
end

stages = File.read(File.join(ROOT, "docs/delivery-stages.md"))
%w[Bootstrap Artifact Feature Vertical\ Slice Final\ Integration Human\ review].each do |term|
  errors << "docs/delivery-stages.md: missing #{term}" unless stages.include?(term.tr("\\", ""))
end

if errors.empty?
  puts "Template and delivery boundaries: OK"
else
  warn errors.join("\n")
  exit 1
end
