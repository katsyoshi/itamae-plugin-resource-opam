
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "itamae-plugin-resource-opam"
  spec.version       = "0.1.0"
  spec.authors       = ["MATSUMOTO, Katsuyoshi"]
  spec.email         = ["github@katsyoshi.org"]

  spec.summary       = %q{itamae plugin for OPAM}
  spec.description   = %q{itamae plugin for OPAM}
  spec.homepage      = "https://github.com/katsyoshi/itamae-plugin-resource-opam"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "itamae"

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "serverspec"
end
