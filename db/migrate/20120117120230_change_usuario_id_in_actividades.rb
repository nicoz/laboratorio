class ChangeUsuarioIdInActividades < ActiveRecord::Migration
  def up
	change_table :actividads do |t|
		t.string :usuario_email
		t.remove :usuario_id
	end

  end

  def down
  end
end
