class RemoveTurnoDiaIdFromTurnos < ActiveRecord::Migration
  def change
    change_table :turno_dia do |t|
      t.remove :turnoDia_id
    end
  end
end
