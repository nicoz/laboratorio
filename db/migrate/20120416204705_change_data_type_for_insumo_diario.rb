class ChangeDataTypeForInsumoDiario < ActiveRecord::Migration
  def up
  	change_table :insumo_diarios do |t|
      		t.change :auxiliar_filtracion, :decimal
    	end
  end

  def down
  end
end
