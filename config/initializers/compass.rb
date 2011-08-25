require 'compass'
require 'compass/app_integration/rails'
FileUtils.mkdir_p(Rails.root.join('tmp', 'stylesheets'))
Rails.configuration.middleware.insert_before('Rack::Sendfile', 'Rack::Static',
    :urls => ['/stylesheets'],
    :root => "#{Rails.root}/tmp")
Compass::AppIntegration::Rails.initialize!
