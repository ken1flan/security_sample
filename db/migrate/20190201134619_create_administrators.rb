class CreateAdministrators < ActiveRecord::Migration[5.2]
  def change
    create_table :administrators do |t|
      t.string :login_id
      t.string :name
      t.string :email
      t.string :password_digest

      t.timestamps
    end
  end
end
