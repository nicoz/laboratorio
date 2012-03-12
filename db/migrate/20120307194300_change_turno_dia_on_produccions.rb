class ChangeTurnoDiaOnProduccions < ActiveRecord::Migration
  def up
	change_table :produccions do |t|
		t.integer :turnoDia_id
		t.remove :turno_dia_id
	end

  end

  def down
  end
end
