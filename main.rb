run "rm -Rf README public/index.html public/javascripts/* test app/views/layouts/*"

run "echo \"source 'http://rubygems.org'\" > Gemfile"

gem "mongo_ext" 
gem "bson_ext", "1.0.1"
gem "mongoid", :git => "git://github.com/durran/mongoid.git"

gem 'haml'

gem 'rails3-generators', :git => "git://github.com/indirect/rails3-generators.git"

gem "rcov",  :group => :test
gem 'rspec', '>=2.0.0.beta.8', :group => :test
gem 'rspec-rails', '>=2.0.0.beta.8', :group => :test
gem "machinist",        :git => "git://github.com/notahat/machinist.git",  :group => :test
gem "faker",  :group => :test
gem "ZenTest",  :group => :test
gem "autotest",  :group => :test
gem "autotest-rails",  :group => :test
gem "cucumber",         :git => "git://github.com/aslakhellesoy/cucumber.git",  :group => :test
gem "database_cleaner", :git => 'git://github.com/bmabey/database_cleaner.git',  :group => :test
gem "cucumber-rails",   :git => "git://github.com/aslakhellesoy/cucumber-rails.git",  :group => :test
gem "capybara",  :group => :test
gem "capybara-envjs",  :group => :test
gem "launchy",  :group => :test
gem "ruby-debug",  :group => :test

gem 'rails', '3.0.0.beta4'



gsub_file 'config/application.rb', /require \"action_mailer\/railtie\"/ do
<<-RUBY
require "action_mailer/railtie"
require 'mongoid/railtie'
RUBY
end

application  <<-GENERATORS 
config.generators do |g|
  g.orm :mongoid
  g.template_engine :haml
  g.test_framework  :rspec, :fixture => false, :views => false
  g.fixture_replacement :factory_girl, :dir => "spec/support/factories"
end
GENERATORS

# RVM
file ".rvmrc", <<-RVMRC
rvm gemset use #{app_name}
RVMRC

current_ruby =  /^(.*):/.match(%x{rvm info})[1]
run "rvm gemset create #{app_name}"
run "rvm gemset use #{app_name}"
run "rvm ree-1.8.7@#{app_name} gem install bundler"
run "rvm ree-1.8.7@#{app_name} -S bundle install"

# Run the generators
run "rvm ree-1.8.7@#{app_name} -S mongoid:config" 
run "rvm ree-1.8.7@#{app_name} -S rails g rspec:install"
run "rvm ree-1.8.7@#{app_name} -S rails g cucumber:install --rspec --capybara"  
# 
# 
# generate "mongoid:config"
# generate "rspec:install"
# generate "cucumber:install --capybara --rspec "
# 

get "http://github.com/rails/jquery-ujs/raw/master/src/rails.js", "public/javascripts/rails.js"
get "http://code.jquery.com/jquery-1.4.2.min.js", "public/javascripts/jquery/jquery-1.4.2.min.js"
get "http://github.com/fmeyer/rails3_template/raw/master/gitignore" ,".gitignore" 
get "http://github.com/fmeyer/rails3_template/raw/master/application.html.haml", "app/views/layouts/application.html.haml"

git :init
git :add => '.'
git :commit => '-am "Initial commit"'
 
puts "SUCCESS!"


