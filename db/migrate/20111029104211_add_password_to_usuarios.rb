class AddPasswordToUsuarios < ActiveRecord::Migration
  def change
    add_column :usuarios, :encrypted_password, :string
  end
end
