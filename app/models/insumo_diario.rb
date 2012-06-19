class InsumoDiario < ActiveRecord::Base
  attr_accessible :aserrin, :chip, :gasoil, :lenia_caldera, :carbon_activado,
    :auxiliar_filtracion, :acido_clorhidrico, :cal_viva, :dia_id


  belongs_to :dia

  validates :aserrin, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => 100000 }
  validates :chip, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => 300000 }
  validates :gasoil, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => 1500 }
  validates :lenia_caldera, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => 300000 }
  validates :auxiliar_filtracion, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => 200 }
  validates :acido_clorhidrico, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => 200 }
  validates :cal_viva, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => 30000 }
  validates :carbon_activado, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => 1000000 }

  validates :dia_id, :presence => true, :uniqueness => true

  def default
    self.aserrin = 0
    self.chip = 0
    self.gasoil = 0
    self.lenia_caldera = 0
    self.carbon_activado = 0
    self.auxiliar_filtracion = 0
    self.acido_clorhidrico = 0
    self.cal_viva = 0
  end
end
