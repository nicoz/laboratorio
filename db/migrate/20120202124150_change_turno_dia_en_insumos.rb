class ChangeTurnoDiaEnInsumos < ActiveRecord::Migration

  def up
	change_table :insumos do |t|
		t.integer :turnoDia_id
		t.remove :turno_dia_id
	end

  end

  def down
  end

end
