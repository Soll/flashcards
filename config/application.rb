require File.expand_path('../boot', __FILE__)

require 'rails/all'

Bundler.require(*Rails.groups)

module Flashcards
  class Application < Rails::Application
    config.autoload_paths += %W["#{config.root}/app/validators/"]
    config.active_record.raise_in_transactional_callbacks = true
  end
end
