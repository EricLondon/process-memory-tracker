class CreateProcessProperties < ActiveRecord::Migration[5.0]
  def change
    create_table :process_properties do |t|
      t.string :name, null: false

      t.timestamps
    end
  end
end
