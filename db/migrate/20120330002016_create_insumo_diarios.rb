class CreateInsumoDiarios < ActiveRecord::Migration
  def change
    create_table :insumo_diarios do |t|
      t.integer :aserrin
      t.integer :chip
      t.integer :gasoil
      t.integer :lenia_caldera
      t.integer :carbon_activado
      t.integer :auxiliar_filtracion
      t.integer :acido_clorhidrico
      t.integer :cal_viva

      t.timestamps
    end
  end
end
