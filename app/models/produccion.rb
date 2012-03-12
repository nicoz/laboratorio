class Produccion < ActiveRecord::Base
	attr_accessible :turnoDia_id, :paquetesPapel, :paquetesPolietileno , :melaza,
			:rubio, :industriaBolsas, :bolsasAzucarlito, :bigBagAzucarlito,
			:bigBagDnd, :bigBagClientes

	belongs_to :turnoDia
	
	validates :turnoDia_id, :presence => true, :uniqueness => true
	
	validates :paquetesPapel, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => 33000 }
	validates :paquetesPolietileno, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => 150000 }
	validates :melaza, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => 25000 }
	validates :rubio, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => 15000 }
	validates :industriaBolsas, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => 100000 }
	validates :bolsasAzucarlito, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => 100000 }
	validates :bigBagAzucarlito, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => 100000 }
	validates :bigBagDnd, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => 100000 }
	validates :bigBagClientes, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => 100000 }
end
