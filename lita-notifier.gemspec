Gem::Specification.new do |spec|
  spec.name          = "lita-notifier"
  spec.version       = "0.2.0"
  spec.authors       = ["Mike Gunderloy"]
  spec.email         = ["MikeG1@larkfarm.com"]
  spec.description   = "Notify one chat room of activity in another chat room"
  spec.summary       = "Notifier for Lita"
  spec.license       = "MIT"
  spec.metadata      = { "lita_plugin_type" => "handler" }

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "lita", ">= 4.5"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "pry-byebug"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rack-test"
  spec.add_development_dependency "rspec", ">= 3.0.0"
end
