class ActiveRecord::Base
	attr_accessor :cu
	before_create :createdby
	before_update :updatedby
	
 
	@@cu = nil

	def self.cu=(usuario)
		#metodo para asignar la variable de clase
		@@cu = usuario
	end
	
	private
		#para cualquier modelo del sistema. Investigo si tiene un campo :updated_by o 
		#created_by. Si lo tiene cargo el valor de la variable de clase cu con el
		#de la variable del sistema usuario_actual (esto esta en permanente cambio desde
		#un filtro del sistema)
		
		def updatedby
			if !@@cu.nil? and self.respond_to?(:updated_by)
				self[:updated_by] = @@cu
			end
		end
		
		def createdby
			if !@@cu.nil? and self.respond_to?(:created_by)
				self[:created_by] = @@cu
			end
		end
end
