class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper
  before_filter :auditar_actividad, :except => [:controller => 'sessions', :action => 'new']
  
  protected
  	def add_breadcrumb name, url = ''
  		@breadcrumbs ||= []
  		url = eval(url) if url =~ /_path|url|@/
  		@breadcrumbs << [name, url]
  	end
  	
  	def self.add_breadcrumb name, url, options = {}
  		before_filter options do |controller|
  			controller.send(:add_breadcrumb, name, url)
  		end
  	end
  	
  	def auditar_actividad
  		parametros = request.filtered_parameters.dup
  		controlador = params[:controller]
  		accion = params[:action]
  		email = "Anonimo"
  		email = usuario_actual.email unless usuario_actual.nil?
  		if filtrar_actividades(controlador, accion)
	  		Actividad.create(
	  			:usuario_email => email,
	  			:controlador => controlador,
	  			:accion => accion,
	  			:parametros => parametros
	  		)
	  	end
  	end
  	
	def autenticar
		negar_acceso unless ingresado?
	end

	def usuario_correcto
		usuario = Usuario.find(params[:id])
		redirect_to(root_path) unless usuario_actual?(usuario) || usuario_actual.admin?
	end
	
  	def usuario_admin
			redirect_to(root_path) unless usuario_actual.admin?
	end
	
	def filtrar_actividades(controlador, accion)
		if ['show', 'index'].include?(accion) or ['paginas'].include?(controlador)
			return false
		else
			return true
		end
	end
end
