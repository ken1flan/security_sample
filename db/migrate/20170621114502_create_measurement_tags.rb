class CreateMeasurementTags < ActiveRecord::Migration[5.1]
  def change
    create_table :measurement_tags do |t|
      t.text :body
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
