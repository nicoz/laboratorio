class ClientePedidoProduccion < ActiveRecord::Base
  attr_accessible :cliente_id, :pedido_produccion_id, :azucar_big_bag, :cliente, :pedido_produccion

	belongs_to :pedido_produccion
	belongs_to :cliente

	def initialize(*params)
		super(*params)
		self.azucar_big_bag = 0
	end

	validates :azucar_big_bag, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => 200000 }
end
