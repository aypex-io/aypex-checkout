require_relative "lib/aypex/checkout/version"

Gem::Specification.new do |s|
  s.platform = Gem::Platform::RUBY
  s.name = "aypex_checkout"
  s.version = Aypex::Checkout.version
  s.authors = ["Matthew Kennedy"]
  s.email = "m.kennedy@me.com"
  s.summary = "A stand alone checkout system for Aypex."
  s.description = s.summary
  s.homepage = "https://github.com/MatthewKennedy/aypex_checkout"
  s.license = "BSD-3-Clause"

  s.metadata = {
    "bug_tracker_uri" => "https://github.com/MatthewKennedy/aypex_checkout/issues",
    "changelog_uri" => "https://github.com/MatthewKennedy/aypex_checkout/releases/tag/v#{s.version}",
    "documentation_uri" => "https://github.com/MatthewKennedy/aypex_checkout",
    "source_code_uri" => "https://github.com/MatthewKennedy/aypex_checkout/tree/v#{s.version}"
  }

  s.required_ruby_version = ">= 2.7"

  s.files = `git ls-files`.split("\n").reject { |f| f.match(/^spec/) && !f.match(/^spec\/fixtures/) }
  s.require_path = "lib"
  s.requirements << "none"

  s.add_dependency "aypex_api", ">= #{s.version}"
  s.add_dependency "aypex_core", ">= #{s.version}"

  s.add_dependency "inline_svg"
  s.add_dependency "responders"
  s.add_dependency "turbo-rails"
end
