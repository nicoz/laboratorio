class RecepcionsController < ApplicationController
	before_filter :autenticar, 		:only => [:create, :new,:edit, :update, :show]
	before_filter :validar_turno_dia,	:only => [:new, :edit]
	add_breadcrumb 'Escritorio', '/escritorio'

	def show
		fecha = Date.parse(params[:fecha])
		@dia = Dia.find_by_fecha(fecha)

		if @dia.recepcion.nil?
			flash[:error] = "Aun no se ingreso la recepcion"
			redirect_to escritorio_path
		end
	end

	def new
		fecha = Date.parse(params[:fecha])
		@dia = Dia.find_or_create_by_fecha(fecha)

		add_breadcrumb "#{l @dia.fecha}", ver_dia_path(@dia.fecha, @dia.fecha)

		if @dia.recepcion.nil?
			add_breadcrumb "Crear Recepcion", crear_recepcion_path(@dia.fecha)
			@recepcion = Recepcion.new
			@recepcion.default
			@title = 'Crear Recepcion de crudo y balance'
		else
			add_breadcrumb "Editar Recepcion", editar_recepcion_path(@dia.fecha)
			@recepcion = @dia.recepcion
			@title = 'Editar Recepcion de crudo y balance'
			render 'edit'
		end
	end

	def create
		@recepcion = Recepcion.new(params[:recepcion])
		if @recepcion.save
			flash[:success] = "Recepcion correctamente creada"
			redirect_to ver_dia_path(@recepcion.dia.fecha)
		else
			@dia = @recepcion.dia
			flash[:error] = @recepcion.polarizacion
			add_breadcrumb "Crear Recepcion", crear_recepcion_path(@recepcion.dia.fecha)
			@title = "Crear Recepcion de crudo y balance"
			render 'new'
		end
	end

	def edit
		fecha = Date.parse(params[:fecha])
		@dia = Dia.find_or_create_by_fecha(fecha)

		add_breadcrumb "#{l @dia.fecha}", ver_dia_path(@dia.fecha, @dia.fecha)

		if @dia.recepcion.nil?
			flash[:error] = "Aun no se ingreso la Recepcion para este dia"
			redirect_to escritorio_path
		else
			add_breadcrumb "Editar Recepcion", editar_recepcion_path(@dia.fecha)
			@recepcion = @dia.recepcion
			@title = 'Editar Recepcion de crudo y balance'
		end
	end

	def update
		@recepcion = Recepcion.find(params[:id])
		if @recepcion.update_attributes(params[:recepcion])
			flash[:success] = "Recepcion correctamente actualizada"
			redirect_to ver_dia_path(@recepcion.dia.fecha)
		else
			add_breadcrumb "Editar Recepcion", editar_recepcion_path(@dia.fecha)
			@title = "Editar Recepcion de crudo y balance"
			render 'edit'
		end
	end

	def validar
	        recepcion = Recepcion.find(params[:id])
		recepcion = Recepcion.new if recepcion.nil?
                dia = Dia.find(params[:dia])
		recepcion[params[:nombre]] = params[:valor]
		recepcion.dia = dia
		if recepcion.valid?
			mensaje = "OK"
		else
			mensaje = recepcion.errors[params[:nombre]]
		end

		render :json => {:mensaje => mensaje}
	end
end
