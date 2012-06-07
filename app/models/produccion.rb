class Produccion < ActiveRecord::Base
	attr_accessible :turnoDia_id, :paquetesPapel, :paquetesPolietileno , :melaza,
			:rubio, :industriaBolsas, :bolsasAzucarlito, :bigBagAzucarlito,
			:bigBagDnd

	belongs_to :turnoDia

	has_many :clientes, :class_name => 'ClienteProduccion'

	def initialize(*params)
		super(*params)
		self.paquetesPapel = 0
		self.paquetesPolietileno = 0
		self.melaza = 0
		self.rubio = 0
		self.industriaBolsas = 0
		self.bolsasAzucarlito = 0
		self.bigBagAzucarlito = 0
		self.bigBagDnd = 0
	end

	validates :turnoDia_id, :presence => true, :uniqueness => true

	validates :paquetesPapel, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => 40000 }
	validates :paquetesPolietileno, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => 150000 }
	validates :melaza, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => 80000 }
	validates :rubio, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => 30000 }
	validates :industriaBolsas, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => 150000 }
	validates :bolsasAzucarlito, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => 150000 }
	validates :bigBagAzucarlito, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => 200000 }
	validates :bigBagDnd, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => 150000 }

end
