#!/usr/bin/env ruby
# frozen_string_literal: true

require "yaml"

ROOT = File.expand_path("..", __dir__)
FORMS = {
  ".github/ISSUE_TEMPLATE/01-artifact-spec.yml" => %w[problem options acceptance exclusions review],
  ".github/ISSUE_TEMPLATE/02-feature.yml" => %w[outcome artifacts slices boundaries acceptance],
  ".github/ISSUE_TEMPLATE/03-vertical-slice.yml" => %w[feature behavior outer inner exclusions review],
  ".github/ISSUE_TEMPLATE/04-final-integration.yml" => %w[prerequisites composition evidence no_new_rules risks]
}.freeze

errors = []

def load_yaml(path, errors)
  YAML.safe_load(File.read(path), permitted_classes: [], aliases: false)
rescue Psych::Exception => error
  errors << "#{path}: invalid YAML (#{error.message})"
  nil
end

Dir.glob(File.join(ROOT, ".github", "**", "*.y{a,}ml")).sort.each do |path|
  load_yaml(path, errors)
end

actual_forms = Dir.glob(File.join(ROOT, ".github/ISSUE_TEMPLATE", "[0-9][0-9]-*.yml")).map do |path|
  path.delete_prefix("#{ROOT}/")
end.sort
errors << "Issue Forms must be exactly: #{FORMS.keys.join(", ")}" unless actual_forms == FORMS.keys.sort

FORMS.each do |relative_path, expected_ids|
  path = File.join(ROOT, relative_path)
  form = load_yaml(path, errors)
  next unless form.is_a?(Hash)

  %w[name description title labels body].each do |key|
    errors << "#{relative_path}: missing #{key}" unless form.key?(key)
  end
  errors << "#{relative_path}: labels must be a non-empty list" unless form["labels"].is_a?(Array) && !form["labels"].empty?
  body = form["body"]
  unless body.is_a?(Array)
    errors << "#{relative_path}: body must be a list"
    next
  end

  fields = body.select { |item| item.is_a?(Hash) && item["type"] == "textarea" }
  ids = fields.map { |item| item["id"] }
  errors << "#{relative_path}: textarea IDs must be exactly #{expected_ids.join(", ")}" unless ids == expected_ids
  fields.each do |field|
    required = field.dig("validations", "required")
    errors << "#{relative_path}: #{field["id"]} must be required" unless required == true
  end
end

config_path = File.join(ROOT, ".github/ISSUE_TEMPLATE/config.yml")
config = load_yaml(config_path, errors)
errors << ".github/ISSUE_TEMPLATE/config.yml: blank_issues_enabled must be false" unless config.is_a?(Hash) && config["blank_issues_enabled"] == false

if errors.empty?
  puts "YAML and Issue Form structure: OK"
else
  warn errors.join("\n")
  exit 1
end
