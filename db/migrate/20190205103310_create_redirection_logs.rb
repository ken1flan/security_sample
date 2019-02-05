class CreateRedirectionLogs < ActiveRecord::Migration[5.2]
  def change
    create_table :redirection_logs do |t|
      t.string :to
      t.string :referer
      t.string :remote_ip
      t.string :user_agent

      t.timestamps
    end
    add_index :redirection_logs, :to
    add_index :redirection_logs, :created_at
  end
end
