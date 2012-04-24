class CreateAnalises < ActiveRecord::Migration
  def change
    create_table :analises do |t|
      t.decimal :azucar_crudo_brix, :precision => 10, :scale => 2
      t.decimal :azucar_crudo_pol, :precision => 10, :scale => 2
      t.decimal :azucar_crudo_pza, :precision => 10, :scale => 2
      t.decimal :azucar_crudo_ph, :precision => 10, :scale => 1
      t.integer :azucar_crudo_color
      t.decimal :azucar_crudo_ceniza, :precision => 10, :scale => 3
      t.decimal :azucar_crudo_invert, :precision => 10, :scale => 3
      t.decimal :azucar_crudo_humedad, :precision => 10, :scale => 3
      
      t.decimal :miel_de_afinacion_brix, :precision => 10, :scale => 2
      t.decimal :miel_de_afinacion_pol, :precision => 10, :scale => 2
      t.decimal :miel_de_afinacion_pza, :precision => 10, :scale => 2
      t.decimal :miel_de_afinacion_ph, :precision => 10, :scale => 1
      t.decimal :miel_de_afinacion_ceniza, :precision => 10, :scale => 3
      t.decimal :miel_de_afinacion_invert, :precision => 10, :scale => 3
      
      t.decimal :azucar_afinada_brix, :precision => 10, :scale => 2
      t.decimal :azucar_afinada_pol, :precision => 10, :scale => 2
      t.decimal :azucar_afinada_pza, :precision => 10, :scale => 2
      t.decimal :azucar_afinada_ph, :precision => 10, :scale => 1
      t.integer :azucar_afinada_color
      t.decimal :azucar_afinada_ceniza, :precision => 10, :scale => 3
      t.decimal :azucar_afinada_invert, :precision => 10, :scale => 3
      t.decimal :azucar_afinada_humedad, :precision => 10, :scale => 3
      
      t.decimal :refundicion_brix, :precision => 10, :scale => 2
      t.decimal :refundicion_pol, :precision => 10, :scale => 2
      t.decimal :refundicion_pza, :precision => 10, :scale => 2
      t.decimal :refundicion_ph, :precision => 10, :scale => 1
      t.integer :refundicion_color
      
      t.decimal :encalado_be, :precision => 10, :scale => 2
      t.decimal :encalado_ph, :precision => 10, :scale => 1
      t.decimal :encalado_alcal, :precision => 10, :scale => 1
      
      t.decimal :jugo_carbonatado_ph, :precision => 10, :scale => 1
      
      t.decimal :primera_filtracion_brix, :precision => 10, :scale => 2
      t.decimal :primera_filtracion_pol, :precision => 10, :scale => 2
      t.decimal :primera_filtracion_pza, :precision => 10, :scale => 2
      t.decimal :primera_filtracion_ph, :precision => 10, :scale => 1
      t.integer :primera_filtracion_color
      
      t.decimal :jarabe_brix, :precision => 10, :scale => 2
      t.decimal :jarabe_pol, :precision => 10, :scale => 2
      t.decimal :jarabe_pza, :precision => 10, :scale => 2
      t.decimal :jarabe_ph, :precision => 10, :scale => 1
      t.integer :jarabe_color
      
      t.decimal :masa_cocida_a_brix, :precision => 10, :scale => 2
      t.decimal :masa_cocida_a_pol, :precision => 10, :scale => 2
      t.decimal :masa_cocida_a_pza, :precision => 10, :scale => 2
      t.decimal :masa_cocida_a_ph, :precision => 10, :scale => 1
      
      t.decimal :masa_cocida_b_brix, :precision => 10, :scale => 2
      t.decimal :masa_cocida_b_pol, :precision => 10, :scale => 2
      t.decimal :masa_cocida_b_pza, :precision => 10, :scale => 2
      t.decimal :masa_cocida_b_ph, :precision => 10, :scale => 1

      t.decimal :masa_cocida_c_brix, :precision => 10, :scale => 2
      t.decimal :masa_cocida_c_pol, :precision => 10, :scale => 2
      t.decimal :masa_cocida_c_pza, :precision => 10, :scale => 2
      t.decimal :masa_cocida_c_ph, :precision => 10, :scale => 1

      t.decimal :masa_cocida_d_brix, :precision => 10, :scale => 2
      t.decimal :masa_cocida_d_pol, :precision => 10, :scale => 2
      t.decimal :masa_cocida_d_pza, :precision => 10, :scale => 2
      t.decimal :masa_cocida_d_ph, :precision => 10, :scale => 1

      t.decimal :masa_cocida_e_brix, :precision => 10, :scale => 2
      t.decimal :masa_cocida_e_pol, :precision => 10, :scale => 2
      t.decimal :masa_cocida_e_pza, :precision => 10, :scale => 2
      t.decimal :masa_cocida_e_ph, :precision => 10, :scale => 1
      
      t.decimal :masa_afinada_1_brix, :precision => 10, :scale => 2
      t.decimal :masa_afinada_1_pol, :precision => 10, :scale => 2
      t.decimal :masa_afinada_1_pza, :precision => 10, :scale => 2
      t.decimal :masa_afinada_1_ph, :precision => 10, :scale => 1

      t.decimal :masa_afinada_2_brix, :precision => 10, :scale => 2
      t.decimal :masa_afinada_2_pol, :precision => 10, :scale => 2
      t.decimal :masa_afinada_2_pza, :precision => 10, :scale => 2
      t.decimal :masa_afinada_2_ph, :precision => 10, :scale => 1

      t.decimal :miel_a_brix, :precision => 10, :scale => 2
      t.decimal :miel_a_pol, :precision => 10, :scale => 2
      t.decimal :miel_a_pza, :precision => 10, :scale => 2
      t.decimal :miel_a_ph, :precision => 10, :scale => 1
      t.integer :miel_a_color
      
      t.decimal :miel_b_brix, :precision => 10, :scale => 2
      t.decimal :miel_b_pol, :precision => 10, :scale => 2
      t.decimal :miel_b_pza, :precision => 10, :scale => 2
      t.decimal :miel_b_ph, :precision => 10, :scale => 1

      t.decimal :miel_c_brix, :precision => 10, :scale => 2
      t.decimal :miel_c_pol, :precision => 10, :scale => 2
      t.decimal :miel_c_pza, :precision => 10, :scale => 2
      t.decimal :miel_c_ph, :precision => 10, :scale => 1

      t.decimal :miel_d_brix, :precision => 10, :scale => 2
      t.decimal :miel_d_pol, :precision => 10, :scale => 2
      t.decimal :miel_d_pza, :precision => 10, :scale => 2
      t.decimal :miel_d_ph, :precision => 10, :scale => 1
      
      t.decimal :miel_e_brix, :precision => 10, :scale => 2
      t.decimal :miel_e_pol, :precision => 10, :scale => 2
      t.decimal :miel_e_pza, :precision => 10, :scale => 2
      t.decimal :miel_e_ph, :precision => 10, :scale => 1

      t.decimal :miel_afinada_1_brix, :precision => 10, :scale => 2
      t.decimal :miel_afinada_1_pol, :precision => 10, :scale => 2
      t.decimal :miel_afinada_1_pza, :precision => 10, :scale => 2
      t.decimal :miel_afinada_1_ph, :precision => 10, :scale => 1

      t.decimal :miel_afinada_2_brix, :precision => 10, :scale => 2
      t.decimal :miel_afinada_2_pol, :precision => 10, :scale => 2
      t.decimal :miel_afinada_2_pza, :precision => 10, :scale => 2
      t.decimal :miel_afinada_2_ph, :precision => 10, :scale => 1

      t.decimal :agua_madre_brix, :precision => 10, :scale => 2
      t.decimal :agua_madre_pol, :precision => 10, :scale => 2
      t.decimal :agua_madre_pza, :precision => 10, :scale => 2
      t.decimal :agua_madre_ph, :precision => 10, :scale => 1

      t.decimal :melaza_brix, :precision => 10, :scale => 2
      t.decimal :melaza_pol, :precision => 10, :scale => 2
      t.decimal :melaza_pza, :precision => 10, :scale => 2
      t.decimal :melaza_ph, :precision => 10, :scale => 1
      t.decimal :melaza_ceniza, :precision => 10, :scale => 3
      t.decimal :melaza_invert, :precision => 10, :scale => 3

      t.integer :azucar_a_color
      t.decimal :azucar_a_humedad, :precision => 10, :scale => 3
      
      t.integer :azucar_b_color
      t.decimal :azucar_b_humedad, :precision => 10, :scale => 3
      
      t.integer :azucar_c_color
      t.decimal :azucar_c_humedad, :precision => 10, :scale => 3
      
      t.integer :azucar_d_color
      t.decimal :azucar_d_humedad, :precision => 10, :scale => 3
      
      t.timestamps
    end
  end
end
