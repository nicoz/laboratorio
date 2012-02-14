class AddHabilitadoBooleanToUsuarios < ActiveRecord::Migration
  def change
  	add_column :usuarios, :habilitado,:boolean,  :default => 'true'
  end
end
