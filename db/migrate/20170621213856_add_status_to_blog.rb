class AddStatusToBlog < ActiveRecord::Migration[5.1]
  def change
    add_column :blogs, :status, :integer, null: false, default: 0
  end
end
