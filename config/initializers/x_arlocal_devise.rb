# If you change this file, restart the server.

Devise.setup do |config|
  require 'devise/orm/active_record'

  config.scoped_views = true

  if Rails.application.credentials.devise
    config.mailer_sender = Rails.application.credentials.devise[:mailer_sender]
  end
end
