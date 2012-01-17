class ActividadesController < ApplicationController
	before_filter :usuario_admin, :only => ["show"]

	add_breadcrumb 'Escritorio', '/escritorio'

	def index
	
	end
	
	def show
		@title = "Ver detalle de la actividad"
		@actividad = Actividad.find(params[:id])
		add_breadcrumb "#{@actividad.controlador} - #{@actividad.accion}", @actividad
	end

end
