require_dependency "admin/application_controller"

module Admin
  class RedirectionLogsController < ApplicationController
    def index
      @search_to = params[:search_to]
      @search_start_at = params[:search_start_at]
      @search_end_at = params[:search_end_at]

      @redirection_logs = RedirectionLog
      @redirection_logs = @redirection_logs.where(to: @search_to) if @search_to.present?
      @redirection_logs = @redirection_logs.where('created_at >= ?', @search_start_at) if @search_start_at.present?
      @redirection_logs = @redirection_logs.where('created_at < ?', @search_end_at) if @search_end_at.present?
      @redirection_logs = @redirection_logs.page(params[:page]).per(10)
    end
  end
end
