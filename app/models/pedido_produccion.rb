class PedidoProduccion < ActiveRecord::Base
  attr_accessible :turnoDia_id, :paquetesPapel, :paquetesPolietileno ,
			:industriaBolsas, :bolsasAzucarlito, :bigBagAzucarlito,
			:bigBagDnd

	belongs_to :dia

	has_many :clientes, :class_name => 'ClientePedidoProduccion'

	def initialize(*params)
		super(*params)
		self.paquetesPapel = 0
		self.paquetesPolietileno = 0
		self.industriaBolsas = 0
		self.bolsasAzucarlito = 0
		self.bigBagAzucarlito = 0
		self.bigBagDnd = 0
	end

	validates :dia_id, :presence => true, :uniqueness => true

	validates :paquetesPapel, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => 40000 }
	validates :paquetesPolietileno, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => 150000 }
	validates :industriaBolsas, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => 150000 }
	validates :bolsasAzucarlito, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => 150000 }
	validates :bigBagAzucarlito, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => 200000 }
	validates :bigBagDnd, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => 150000 }

  def total_bolsas
    self.industriaBolsas + self.bolsasAzucarlito
  end
  
  def total_big_bag
    total_clientes = 0
    
    self.clientes.each do |cliente|
      total_clientes += cliente.azucar_big_bag
    end
    
    total_clientes.to_f + self.bigBagAzucarlito.to_f + self.bigBagDnd.to_f
  end
  
  def total_azucar_blanco
    total_bolsas + total_big_bag + self.paquetesPapel + self.paquetesPolietileno
  end
end
