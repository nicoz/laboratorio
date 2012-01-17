class PaginasController < ApplicationController
	add_breadcrumb 'Inicio', '/'

  def inicio
	if usuario_actual.nil?
		redirect_back_or ingresar_path(usuario_actual)
	else
		redirect_back_or escritorio_path(usuario_actual)
	end
  end

  def contacto
  	add_breadcrumb 'Contacto', contacto_path
  	@title = "Contacto"
  end

  def acerca
  	@title = "Acerca de"
  end
  
  def ayuda
  	add_breadcrumb 'Ayuda', ayuda_path
  	@title = "Ayuda"
  end

end
