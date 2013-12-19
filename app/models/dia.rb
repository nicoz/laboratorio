class Dia < ActiveRecord::Base
	attr_accessible :fecha, :activo, :turnos_attributes, :id, :observaciones
	after_initialize :default_values
	before_destroy :dia_con_turnos?

	has_many :turnos, :class_name => 'TurnoDia'

	has_one :insumoDiario
	has_one :produccionMasa
	has_one :recepcion
	has_one :pedido_produccion

	validates :fecha, :presence => true,
			  :uniqueness => true


	accepts_nested_attributes_for :turnos

	private
		def default_values
			self.activo ||= true
		end

		def dia_con_turnos?
			errors.add(:base, "No se puede eliminar un dia que tenga turnos creados") unless turnos.count == 0

			errors.blank? #comprueba si la lista de elementos esta vacia, si lo esta permite borrar
		end
end
