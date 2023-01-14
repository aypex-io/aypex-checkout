require_relative "lib/aypex/checkout/version"

Gem::Specification.new do |spec|
  spec.platform = Gem::Platform::RUBY
  spec.name = "aypex-checkout"
  spec.version = Aypex::Checkout.version
  spec.authors = ["Matthew Kennedy"]
  spec.email = "m.kennedy@me.com"
  spec.summary = "A stand alone checkout system for Aypex."
  spec.description = spec.summary
  spec.homepage = "https://github.com/aypex-io/aypex-checkout"
  spec.license = "BSD-3-Clause"

  spec.metadata = {
    "bug_tracker_uri" => "https://github.com/aypex-io/aypex-checkout/issues",
    "changelog_uri" => "https://github.com/aypex-io/aypex-checkout/releases/tag/v#{spec.version}",
    "documentation_uri" => "https://github.com/aypex-io/aypex-checkout",
    "source_code_uri" => "https://github.com/aypex-io/aypex-checkout/tree/v#{spec.version}"
  }

  spec.required_ruby_version = ">= 3.2"

  spec.files = `git ls-files`.split("\n").reject { |f| f.match(/^spec/) && !f.match(/^spec\/fixtures/) }
  spec.require_path = "lib"
  spec.requirements << "none"

  spec.add_dependency "aypex"
  spec.add_dependency "aypex-api"

  spec.add_dependency "inline_svg"
  spec.add_dependency "responders"
  spec.add_dependency "turbo-rails"

  spec.add_development_dependency "aypex_dev_tools"
end
