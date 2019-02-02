module Admin
  class Engine < ::Rails::Engine
    isolate_namespace Admin

    config.autoload_paths << File.expand_path("#{Rails.root}/app/models", __dir__)
  end
end
