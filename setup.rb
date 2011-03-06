#!/usr/bin/env ruby

if ARGV.first.nil?
  puts 'Usage: pass a CamelCased name for your app, and this program will replace occurences of GenericApp and generic_app with your name.'
  exit 1
else
  appName = ARGV.first # CamelCase version
  # app_name = # under_score version
end

FILES = [
  'Rakefile',
  'config.ru',
  'config/application.rb',
  'config/environment.rb',
  'config/environments/development.rb',
  'config/environments/production.rb',
  'config/environments/test.rb',
  'config/initializers/secret_token.rb',
  'config/initializers/session_store.rb',
  'config/initializers/session_store.rb',
  'config/routes.rb']

FILES.each do |filename|
  text = File.read(filename).gsub('GenericApp', appName)
  File.open(filename, 'w') { |file| file.puts text }
end
