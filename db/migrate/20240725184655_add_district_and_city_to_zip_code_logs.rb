class AddDistrictAndCityToZipCodeLogs < ActiveRecord::Migration[7.0]
  def change
    add_column :zip_code_logs, :district, :string
    add_column :zip_code_logs, :city, :string
  end
end
