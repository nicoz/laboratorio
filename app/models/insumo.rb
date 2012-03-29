class Insumo < ActiveRecord::Base 
	attr_accessible :turnoDia_id, :aserrin, :crudoProcesado, :leniaCaldera,
		       :carbonActivado, :auxiliarDeFiltracion, :piedra_de_cal , :turnoDia_id,
		       :chip
		       
	belongs_to :turnoDia
	
	def initialize(*params)
		super(*params)
		self.crudoProcesado = 0
	end
	
	validates :turnoDia_id, :presence => true, :uniqueness => true
	
	validates :crudoProcesado, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => 250000 }
	
end
