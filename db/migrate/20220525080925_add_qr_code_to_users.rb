class AddQrCodeToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :qr_code, :string
  end
end
