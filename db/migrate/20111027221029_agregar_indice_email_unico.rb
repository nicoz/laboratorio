class AgregarIndiceEmailUnico < ActiveRecord::Migration
  def up
  	add_index :usuarios, :email, :unique => true
  end

  def down
  	remove_index :usuarios, :email
  end
end
