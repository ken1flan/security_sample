require_dependency "admin/application_controller"

module Admin
  class RedirectionLogsController < ApplicationController
    def index
      @redirection_logs = RedirectionLog.all
    end
  end
end
