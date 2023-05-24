class ChangeZipCodetoString < ActiveRecord::Migration[7.0]
  def change
    change_column :applications, :zip_code, :string
  end
end
