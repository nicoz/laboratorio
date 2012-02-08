class CreateTurnoDia < ActiveRecord::Migration
  def change
    create_table :turno_dia do |t|
      t.integer :dia_id
      t.integer :turno_id
      t.string :estado

      t.timestamps
    end
  end
end
