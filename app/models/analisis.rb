class Analisis < ActiveRecord::Base
  attr_accessible  :azucar_crudo_brix, :azucar_crudo_pol, :azucar_crudo_pza,
                   :azucar_crudo_ph, :azucar_crudo_color, :azucar_crudo_ceniza,
                   :azucar_crudo_invert, :azucar_crudo_humedad,
                   :miel_de_afinacion_brix, :miel_de_afinacion_pol,
                   :miel_de_afinacion_pza, :miel_de_afinacion_ph,
                   :miel_de_afinacion_ceniza, :miel_de_afinacion_invert,
                   :azucar_afinada_brix, :azucar_afinada_pol,
                   :azucar_afinada_pza, :azucar_afinada_ph, :azucar_afinada_color,
                   :azucar_afinada_ceniza, :azucar_afinada_invert,
                   :azucar_afinada_humedad, :refundicion_brix, :refundicion_pol,
                   :refundicion_pza, :refundicion_ph, :refundicion_color,
                   :encalado_be, :encalado_ph, :encalado_alcal,
                   :jugo_carbonatado_ph, :primera_filtracion_brix,
                   :primera_filtracion_pol, :primera_filtracion_pza,
                   :primera_filtracion_ph, :primera_filtracion_color,
                   :jarabe_brix, :jarabe_pol, :jarabe_pza, :jarabe_ph,
                   :jarabe_color, :masa_cocida_a_brix, :masa_cocida_a_pol,
                   :masa_cocida_a_pza, :masa_cocida_a_ph, :masa_cocida_b_brix,
                   :masa_cocida_b_pol, :masa_cocida_b_pza, :masa_cocida_b_ph,
                   :masa_cocida_c_brix, :masa_cocida_c_pol, :masa_cocida_c_pza,
                   :masa_cocida_c_ph, :masa_cocida_d_brix, :masa_cocida_d_pol,
                   :masa_cocida_d_pza, :masa_cocida_d_ph, :masa_cocida_e_brix,
                   :masa_cocida_e_pol, :masa_cocida_e_pza, :masa_cocida_e_ph,
                   :masa_afinada_1_brix, :masa_afinada_1_pol, :masa_afinada_1_pza,
                   :masa_afinada_1_ph, :masa_afinada_2_brix, :masa_afinada_2_pol,
                   :masa_afinada_2_pza, :masa_afinada_2_ph, :miel_a_brix,
                   :miel_a_pol, :miel_a_pza, :miel_a_ph, :miel_a_color,
                   :miel_b_brix, :miel_b_pol, :miel_b_pza, :miel_b_ph,
                   :miel_c_brix, :miel_c_pol, :miel_c_pza, :miel_c_ph,
                   :miel_d_brix, :miel_d_pol, :miel_d_pza, :miel_d_ph,
                   :miel_e_brix, :miel_e_pol, :miel_e_pza, :miel_e_ph,
                   :miel_afinada_1_brix, :miel_afinada_1_pol,
                   :miel_afinada_1_pza, :miel_afinada_1_ph, :miel_afinada_2_brix,
                   :miel_afinada_2_pol, :miel_afinada_2_pza, :miel_afinada_2_ph,
                   :agua_madre_brix, :agua_madre_pol, :agua_madre_pza,
                   :agua_madre_ph, :melaza_brix, :melaza_pol, :melaza_pza,
                   :melaza_ph, :melaza_ceniza, :melaza_invert, :azucar_a_color,
                   :azucar_a_humedad, :azucar_b_color, :azucar_b_humedad,
                   :azucar_c_color, :azucar_c_humedad, :azucar_d_color,
                   :azucar_d_humedad, :turnoDia_id

                   belongs_to :turnoDia

                   validates :turnoDia_id, :presence => true, :uniqueness => true

                   # VALIDACIONES DE BRIX #####################################################################################
                   #validates :azucar_crudo_brix,  :allow_nil => true, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => 100 }
                   validates :azucar_crudo_brix,  :allow_nil => true, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => 100 }
                   validates :miel_de_afinacion_brix,  :allow_nil => true, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => 100 }
                   validates :azucar_afinada_brix,  :allow_nil => true, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => 100 }
                   validates :refundicion_brix,  :allow_nil => true, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => 100 }
                   validates :primera_filtracion_brix,  :allow_nil => true, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => 100 }
                   validates :jarabe_brix,  :allow_nil => true, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => 100 }
                   validates :masa_cocida_a_brix,  :allow_nil => true, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => 100 }
                   validates :masa_cocida_b_brix,  :allow_nil => true, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => 100 }
                   validates :masa_cocida_c_brix,  :allow_nil => true, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => 100 }
                   validates :masa_cocida_d_brix,  :allow_nil => true, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => 100 }
                   validates :masa_cocida_e_brix,  :allow_nil => true, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => 100 }
                   validates :masa_afinada_1_brix,  :allow_nil => true, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => 100 }
                   validates :masa_afinada_2_brix,  :allow_nil => true, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => 100 }
                   validates :miel_a_brix,  :allow_nil => true, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => 100 }
                   validates :miel_b_brix,  :allow_nil => true, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => 100 }
                   validates :miel_c_brix,  :allow_nil => true, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => 100 }
                   validates :miel_d_brix,  :allow_nil => true, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => 100 }
                   validates :miel_e_brix,  :allow_nil => true, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => 100 }
                   validates :miel_afinada_1_brix,  :allow_nil => true, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => 100 }
                   validates :miel_afinada_2_brix,  :allow_nil => true, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => 100 }
                   validates :agua_madre_brix,  :allow_nil => true, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => 100 }
                   validates :melaza_brix,  :allow_nil => true, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => 100 }

                   # VALIDACIONES DE POL ##############################################################################################
                   validates :azucar_crudo_pol,  :allow_nil => true, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => 100 }
                   validates :miel_de_afinacion_pol,  :allow_nil => true, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => 100 }
                   validates :azucar_afinada_pol,  :allow_nil => true, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => 100 }
                   validates :refundicion_pol,  :allow_nil => true, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => 100 }
                   validates :primera_filtracion_pol,  :allow_nil => true, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => 100 }
                   validates :jarabe_pol,  :allow_nil => true, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => 100 }
                   validates :masa_cocida_a_pol,  :allow_nil => true, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => 100 }
                   validates :masa_cocida_b_pol,  :allow_nil => true, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => 100 }
                   validates :masa_cocida_c_pol,  :allow_nil => true, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => 100 }
                   validates :masa_cocida_d_pol,  :allow_nil => true, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => 100 }
                   validates :masa_cocida_e_pol,  :allow_nil => true, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => 100 }
                   validates :masa_afinada_1_pol,  :allow_nil => true, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => 100 }
                   validates :masa_afinada_2_pol,  :allow_nil => true, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => 100 }
                   validates :miel_a_pol,  :allow_nil => true, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => 100 }
                   validates :miel_b_pol,  :allow_nil => true, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => 100 }
                   validates :miel_c_pol,  :allow_nil => true, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => 100 }
                   validates :miel_d_pol,  :allow_nil => true, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => 100 }
                   validates :miel_e_pol,  :allow_nil => true, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => 100 }
                   validates :miel_afinada_1_pol,  :allow_nil => true, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => 100 }
                   validates :miel_afinada_2_pol,  :allow_nil => true, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => 100 }
                   validates :agua_madre_pol,  :allow_nil => true, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => 100 }
                   validates :melaza_pol,  :allow_nil => true, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => 100 }

                   # VALIDACIONES DE PH ##############################################################################################
                   validates :azucar_crudo_ph,  :allow_nil => true, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => 14 }
                   validates :miel_de_afinacion_ph,  :allow_nil => true, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => 14 }
                   validates :azucar_afinada_ph,  :allow_nil => true, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => 14 }
                   validates :refundicion_ph,  :allow_nil => true, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => 14 }
                   validates :encalado_ph,  :allow_nil => true, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => 14 }
                   validates :jugo_carbonatado_ph,  :allow_nil => true, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => 14 }
                   validates :primera_filtracion_ph,  :allow_nil => true, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => 14 }
                   validates :jarabe_ph,  :allow_nil => true, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => 14 }
                   validates :masa_cocida_a_ph,  :allow_nil => true, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => 14 }
                   validates :masa_cocida_b_ph,  :allow_nil => true, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => 14 }
                   validates :masa_cocida_c_ph,  :allow_nil => true, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => 14 }
                   validates :masa_cocida_d_ph,  :allow_nil => true, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => 14 }
                   validates :masa_cocida_e_ph,  :allow_nil => true, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => 14 }
                   validates :masa_afinada_1_ph,  :allow_nil => true, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => 14 }
                   validates :masa_afinada_2_ph,  :allow_nil => true, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => 14 }
                   validates :miel_a_ph,  :allow_nil => true, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => 14 }
                   validates :miel_b_ph,  :allow_nil => true, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => 14 }
                   validates :miel_c_ph,  :allow_nil => true, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => 14 }
                   validates :miel_d_ph,  :allow_nil => true, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => 14 }
                   validates :miel_e_ph,  :allow_nil => true, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => 14 }
                   validates :miel_afinada_1_ph,  :allow_nil => true, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => 14 }
                   validates :miel_afinada_2_ph,  :allow_nil => true, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => 14 }
                   validates :agua_madre_ph,  :allow_nil => true, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => 14 }
                   validates :melaza_ph,  :allow_nil => true, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => 14 }

                   # VALIDACIONES COLOR #######################################################################################
                   validates :azucar_crudo_color,  :allow_nil => true, :numericality => { :greater_than => 0, :less_than_or_equal_to => 10000 }
                   validates :azucar_afinada_color,  :allow_nil => true, :numericality => { :greater_than => 0, :less_than_or_equal_to => 10000 }
                   validates :refundicion_color,  :allow_nil => true, :numericality => { :greater_than => 0, :less_than_or_equal_to => 10000 }
                   validates :primera_filtracion_color,  :allow_nil => true, :numericality => { :greater_than => 0, :less_than_or_equal_to => 10000 }
                   validates :jarabe_color,  :allow_nil => true, :numericality => { :greater_than => 0, :less_than_or_equal_to => 10000 }
                   validates :miel_a_color,  :allow_nil => true, :numericality => { :greater_than => 0, :less_than_or_equal_to => 10000 }
                   validates :azucar_a_color,  :allow_nil => true, :numericality => { :greater_than => 0, :less_than_or_equal_to => 500 }
                   validates :azucar_b_color,  :allow_nil => true, :numericality => { :greater_than => 0, :less_than_or_equal_to => 500 }
                   validates :azucar_c_color,  :allow_nil => true, :numericality => { :greater_than => 0, :less_than_or_equal_to => 500 }
                   validates :azucar_d_color,  :allow_nil => true, :numericality => { :greater_than => 0, :less_than_or_equal_to => 500 }

                   # VALIDACIONES DE CENIZA ####################################################################################
                   validates :azucar_crudo_ceniza,  :allow_nil => true, :numericality => { :greater_than => 0, :less_than_or_equal_to => 100 }
                   validates :miel_de_afinacion_ceniza,  :allow_nil => true, :numericality => { :greater_than => 0, :less_than_or_equal_to => 100 }
                   validates :azucar_afinada_ceniza,  :allow_nil => true, :numericality => { :greater_than => 0, :less_than_or_equal_to => 100 }
                   validates :melaza_ceniza,  :allow_nil => true, :numericality => { :greater_than => 0, :less_than_or_equal_to => 100 }

                   # VALIDACIONES DE INVERT #####################################################################################
                   validates :azucar_crudo_invert,  :allow_nil => true, :numericality => { :greater_than => 0, :less_than_or_equal_to => 100 }
                   validates :miel_de_afinacion_invert,  :allow_nil => true, :numericality => { :greater_than => 0, :less_than_or_equal_to => 100 }
                   validates :azucar_afinada_invert,  :allow_nil => true, :numericality => { :greater_than => 0, :less_than_or_equal_to => 100 }
                   validates :melaza_invert,  :allow_nil => true, :numericality => { :greater_than => 0, :less_than_or_equal_to => 100 }

                   # VALIDACIONES DE ALCAL ######################################################################################
                   validates :encalado_alcal, :allow_nil => true, :numericality => { :greater_than => 0, :less_than_or_equal_to => 20 }

                   # VALIDACIONES DE HUM ########################################################################################
                   validates :azucar_crudo_humedad, :allow_nil => true, :numericality => { :greater_than => 0, :less_than_or_equal_to => 100 }
                   validates :azucar_afinada_humedad, :allow_nil => true, :numericality => { :greater_than => 0, :less_than_or_equal_to => 100 }
                   validates :azucar_a_humedad, :allow_nil => true, :numericality => { :greater_than => 0, :less_than_or_equal_to => 100 }
                   validates :azucar_b_humedad, :allow_nil => true, :numericality => { :greater_than => 0, :less_than_or_equal_to => 100 }
                   validates :azucar_c_humedad, :allow_nil => true, :numericality => { :greater_than => 0, :less_than_or_equal_to => 100 }
                   validates :azucar_d_humedad, :allow_nil => true, :numericality => { :greater_than => 0, :less_than_or_equal_to => 100 }
                   validates :azucar_a_humedad, :allow_nil => true, :numericality => { :greater_than => 0, :less_than_or_equal_to => 100 }
end
