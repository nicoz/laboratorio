class AddAdminToUsuarios < ActiveRecord::Migration
  def change
    add_column :usuarios, :admin, :boolean
  end
end
