module SessionsHelper

	def ingresar(usuario)
		cookies.permanent.signed[:remember_token] = [usuario.id, usuario.salt]
		self.usuario_actual = usuario
	end
	
	def usuario_actual=(usuario)
		@usuario_actual = usuario
	end
	
	def usuario_actual
		@usuario_actual ||= usuario_de_remember_token
	end
	
	def ingresado?
		!usuario_actual.nil?
	end
	
	def salir
		cookies.delete(:remember_token)
		self.usuario_actual = nil
	end
	
	private
	
		def usuario_de_remember_token
			Usuario.authenticate_with_salt(*remember_token)
		end
		
		def remember_token
			cookies.signed[:remember_token] || [nil, nil]
		end
end
