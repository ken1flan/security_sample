module Admin
  class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception

    include Admin::SessionsHelper
  end
end
