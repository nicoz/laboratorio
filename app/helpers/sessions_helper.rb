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
	
	def usuario_actual?(usuario)
		usuario == usuario_actual
	end
	
	def negar_acceso
		guardar_lugar
		redirect_to ingresar_path, :notice => "Por favor ingrese antes de acceder a esta pagina"
	end
	
	def redirect_back_or(default)
		redirect_to(session[:return_to] || default)
		limpiar_return_to
	end
	
	private
	
		def usuario_de_remember_token
			Usuario.authenticate_with_salt(*remember_token)
		end
		
		def remember_token
			cookies.signed[:remember_token] || [nil, nil]
		end
		
		def guardar_lugar
			session[:return_to] = request.fullpath
		end
		
		def limpiar_return_to
			session[:return_to] = nil
		end
end
