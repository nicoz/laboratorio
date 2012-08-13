class ActividadesController < ApplicationController
	before_filter :usuario_admin, :only => ["show"]
        before_filter :solo_reportes

	add_breadcrumb 'Escritorio', '/escritorio'

	def index
		add_breadcrumb 'Actividades', usuarios_path
		@title = "Visor de Actividades"
		@search = Actividad.search(params[:search])
		@actividades = @search.paginate(:page => params[:page], :per_page => 10, :order => 'created_at DESC')
		@busqueda = params[:search]
	end

	def show
		@title = "Ver detalle de la actividad"
		@actividad = Actividad.find(params[:id])
		add_breadcrumb "#{@actividad.controlador} - #{@actividad.accion}", @actividad
	end

end
