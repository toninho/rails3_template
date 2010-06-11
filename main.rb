run "rm -Rf README public/index.html public/javascripts/* test app/views/layouts/*"

gem 'rails', '3.0.0.beta4'

gem "mongo_ext" 
gem "mongoid", "2.0.0.beta6"
gem "bson_ext", "1.0.1"

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

application  <<-GENERATORS 
config.generators do |g|
  g.orm :mongoid
  g.template_engine :haml
  g.test_framework  :rspec, :fixture => false, :views => false
  g.fixture_replacement :factory_girl, :dir => "spec/support/factories"
end
GENERATORS

run "bundle install"
generate "rspec:install"
generate "cucumber:install --capybara --rspec "
generate "mongoid:config"

get "http://github.com/rails/jquery-ujs/raw/master/src/rails.js", "public/javascripts/rails.js"
get "http://code.jquery.com/jquery-1.4.2.min.js", "public/javascripts/jquery/jquery-1.4.2.min.js"
get "http://github.com/fmeyer/rails3_template/raw/master/gitignore" ,".gitignore" 
get "http://github.com/fmeyer/rails3_template/raw/master/application.html.haml", "app/views/layouts/application.html.haml"

git :init
git :add => '.'
git :commit => '-am "Initial commit"'
 
puts "SUCCESS!"
