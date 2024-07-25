class CreateZipCodeLogs < ActiveRecord::Migration[7.0]
  def change
    create_table :zip_code_logs do |t|
      t.string :zip_code
      t.string :state
      t.integer :search_count, default: 0

      t.timestamps
    end
  end
end
