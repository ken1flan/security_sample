class RedirectionLog < ApplicationRecord
  def self.write(request)
    create(
      to: request.params[:to],
      referer: request.referer,
      remote_ip: request.remote_ip,
      user_agent: request.user_agent,
    )
  end
end
