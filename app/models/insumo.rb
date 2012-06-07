class Insumo < ActiveRecord::Base
	attr_accessible :turnoDia_id, :crudoProcesado, :tiraje

	belongs_to :turnoDia

	def initialize(*params)
		super(*params)
		self.crudoProcesado = 0
		self.tiraje = 0
	end

	validates :turnoDia_id, :presence => true, :uniqueness => true

	validates :crudoProcesado, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => 250000 }
	validates :tiraje, :numericality => {:greater_than_or_equal_to => 0, :less_than_or_equal_to => 300 }

end
