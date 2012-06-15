class CreateZafras < ActiveRecord::Migration
  def change
    create_table :zafras do |t|
      t.date :dia_inicio
      t.date :dia_fin

      t.timestamps
    end
  end
end
