class Insumo < ActiveRecord::Base 
	attr_accessible :turnoDia_id, :aserrin, :crudoProcesado, :leniaCaldera,
		       :carbonActivado, :auxiliarDeFiltracion, :piedra_de_cal , :turnoDia_id,
		       :chip
		       
	belongs_to :turnoDia
	
	validates :turnoDia_id, :presence => true, :uniqueness => true
	
	validates :aserrin, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => 1000000 }
	validates :chip, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => 1000000 }
	
	validates :crudoProcesado, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => 250000 }
	validates :leniaCaldera, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => 99999 }
	validates :carbonActivado, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => 1500 }
	validates :auxiliarDeFiltracion, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => 99 }
	validates :piedra_de_cal, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => 15000 }
end
