# frozen_string_literal: true

require_relative 'lib/solidus_pagy/version'

Gem::Specification.new do |s|
  s.name = 'solidus_pagy'
  s.version = SolidusPagy::VERSION
  s.authors = ['Jonathan Tapia']
  s.email = 'jonathan.tapia@magmalabs.io'

  s.summary = 'Solidus extension using Pagy pagination.'
  s.description = 'Solidus extension using Pagy pagination.'
  s.homepage = 'https://github.com/solidusio-contrib/solidus_pagy#readme'
  s.license = 'BSD-3-Clause'

  if s.respond_to?(:metadata)
    s.metadata['homepage_uri'] = s.homepage
    s.metadata['source_code_uri'] = 'https://github.com/jtapia/solidus_pagy'
    s.metadata['rubygems_mfa_required'] = 'true'
    s.metadata['changelog_uri'] = 'https://github.com/jtapia/solidus_pagy/blob/master/CHANGELOG.md'
  end

  s.required_ruby_version = Gem::Requirement.new('>= 2.5')

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  files = Dir.chdir(__dir__) { `git ls-files -z`.split("\x0") }

  s.files = files.grep_v(%r{^(test|spec|features)/})
  s.test_files = files.grep(%r{^(test|spec|features)/})
  s.bindir = 'exe'
  s.executables = files.grep(%r{^exe/}) { |f| File.basename(f) }
  s.require_paths = ['lib']

  solidus_version = ['>= 2.5', '< 4']

  s.add_dependency 'pagy', '~> 5.10'
  s.add_dependency 'solidus_core', solidus_version
  s.add_dependency 'solidus_support', '~> 0.5'

  s.add_development_dependency 'solidus_backend', solidus_version
  s.add_development_dependency 'solidus_dev_support', '~> 2.5'
  s.add_development_dependency 'solidus_frontend', solidus_version
end
