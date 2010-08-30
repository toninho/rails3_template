run "rm -Rf README public/index.html public/javascripts/* test app/views/layouts/*"
run "echo \"source 'http://rubygems.org'\" > Gemfile"

# GEMS
gem 'rails', '3.0.0'

gem 'warden'
gem 'devise'
gem 'cancan'

gem 'inherited_resources', '1.1.2'

gem 'will_paginate', '>= 3.0.pre2'
#gem 'searchlogic'
gem 'friendly_id', '~> 3.1'

gem 'mysql2'

gem 'tabs_on_rails', :source => 'http://gemcutter.org'

gem 'rails3-generators', :git => "git://github.com/indirect/rails3-generators.git"

gem 'rspec', '>=2.0.0.beta.8',        :group => :test
gem 'rspec-rails', '>=2.0.0.beta.8',  :group => :test
gem "factory_girl_rails",             :group => :test
gem "ZenTest",                        :group => :test
gem "autotest",                       :group => :test
gem "autotest-rails",                 :group => :test
gem "cucumber",                       :group => :test, :git => "git://github.com/aslakhellesoy/cucumber.git"
gem "database_cleaner",               :group => :test, :git => 'git://github.com/bmabey/database_cleaner.git'
gem "cucumber-rails",                 :group => :test, :git => "git://github.com/aslakhellesoy/cucumber-rails.git"
gem "capybara",                       :group => :test
gem "capybara-envjs",                 :group => :test
gem "ruby-debug",                     :group => :test

# PLUGINS
plugin 'asset_packager', :git => 'git://github.com/sbecker/asset_packager.git'

gsub_file 'config/application.rb', /require \"action_mailer\/railtie\"/ do
<<-RUBY
require "action_mailer/railtie"
RUBY
end

application  <<-GENERATORS 
config.generators do |g|
  g.test_framework  :rspec, :fixture => false, :views => false
  g.fixture_replacement :factory_girl, :dir => "spec/support/factories"
end
GENERATORS

# RVM
# file ".rvmrc", <<-RVMRC
# rvm gemset use #{app_name}
# RVMRC

# current_ruby =  /^(.*):/.match(%x{rvm info})[1]
# run "rvm gemset create #{app_name}"
# run "rvm gemset use #{app_name}"
# run "rvm 1.9.2 gem install bundler"
run "rvm 1.9.2 -S bundle install"

# Run the generators
run "rvm 1.9.2 -S rails g devise:install"
run "rvm 1.9.2 -S rails g devise User"
run "rvm 1.9.2 -S rails g friendly_id"
run "rvm 1.9.2 -S rails g rspec:install"
run "rvm 1.9.2 -S rails g cucumber:install --rspec --capybara"  

#Rake tasks
rake 'asset:packager:create_yml' 

get "http://github.com/toninho/rails3_template/raw/master/gitignore" ,".gitignore" 
get "http://github.com/toninho/rails3_template/raw/master/application.html.erb", "app/views/layouts/application.html.erb"

git :init
git :add => '.'
git :commit => '-am "Initial commit"'
 
puts "SUCCESS!"