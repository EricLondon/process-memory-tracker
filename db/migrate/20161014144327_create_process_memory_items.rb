class CreateProcessMemoryItems < ActiveRecord::Migration[5.0]
  def change
    create_table :process_memory_items do |t|
      t.references :process_property, null: false, index: true, foreign_key: true
      t.bigint :memory, null: false

      t.timestamps
    end
  end
end
