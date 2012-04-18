class Recepcion < ActiveRecord::Base
	attr_accessible :azucar_crudo, :polarizacion, :perdida_en_azucar, :azucar_en_melaza, :dia_id
	
	belongs_to :dia
	
	def default
		self.azucar_crudo = 0
		self.polarizacion = 90
		self.perdida_en_azucar = 0
		self.azucar_en_melaza = 0
	end
	
	validates :azucar_crudo, :numericality => {:greater_than_or_equal_to => 0, :less_than_or_equal_to => 600000}
	validates :polarizacion, :numericality => {:greater_than_or_equal_to => 90, :less_than_or_equal_to => 99.99}
	validates :perdida_en_azucar, :numericality => {:greater_than_or_equal_to => 0, :less_than_or_equal_to => 9.9}
	validates :azucar_en_melaza, :numericality => {:greater_than_or_equal_to => 0, :less_than_or_equal_to => 9.9}
	
	validates :dia_id, :presence => true, :uniqueness => true
end
