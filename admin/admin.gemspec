$:.push File.expand_path('lib', __dir__)

require 'admin/version'

Gem::Specification.new do |spec|
  spec.name        = 'admin'
  spec.version     = Admin::VERSION
  spec.authors     = ['ken1flan']
  spec.email       = ['ken1flan@gmail.com']
  spec.homepage    = 'https://github.com/ken1flan'
  spec.summary     = 'admin site of security sample application.'
  spec.description = 'admin site of security sample application.'
  spec.license     = 'MIT'

  spec.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']

  spec.add_dependency 'rails', '~> 5.2.2'

  spec.add_development_dependency 'sqlite3'
end
