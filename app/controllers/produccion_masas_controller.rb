class ProduccionMasasController < ApplicationController
        before_filter :autenticar, 		:only => [:create, :new,:edit, :update, :show]
	before_filter :validar_turno_dia,	:only => [:new, :edit]
	before_filter :solo_reportes
	before_filter :zafra_abierta, :only => [:new, :edit, :create, :update, :destroy]
	add_breadcrumb 'Escritorio', '/escritorio'

	def show
		fecha = Date.parse(params[:fecha])
		@dia = Dia.find_by_fecha(fecha)

		if @dia.produccionMasa.nil?
			flash[:error] = "Aun no se ingreso la produccion de masas cocidas"
			redirect_to escritorio_path
		end
	end

	def new
		fecha = Date.parse(params[:fecha])
		@dia = Dia.find_or_create_by_fecha(fecha)

		add_breadcrumb "#{l @dia.fecha}", ver_dia_path(@dia.fecha, @dia.fecha)

		if @dia.produccionMasa.nil?
			add_breadcrumb "Crear Produccion Masas Cocidas", crear_insumo_diario_path(@dia.fecha)
			@produccionMasa = ProduccionMasa.new
			@title = 'Crear Produccion Masas Cocidas'
		else
			add_breadcrumb "Editar Produccion Masas Cocidas", editar_insumo_diario_path(@dia.fecha)
			@produccionMasa = @dia.produccionMasa
			@title = 'Editar Produccion Masas Cocidas'
			render 'edit'
		end
	end

	def create
		@produccionMasa = ProduccionMasa.new(params[:produccion_masa])
		if @produccionMasa.save
			flash[:success] = "Produccion Masas Cocidas correctamente creadas"
			redirect_to ver_dia_path(@produccionMasa.dia.fecha)
		else
			add_breadcrumb "Crear Produdccion Masas Cocidas", crear_insumo_diario_path(@produccionMasa.dia.fecha)
			@title = "Crear Produccion Masas Cocidas"
			render 'new'
		end
	end

	def edit
		fecha = Date.parse(params[:fecha])
		@dia = Dia.find_or_create_by_fecha(fecha)

		add_breadcrumb "#{l @dia.fecha}", ver_dia_path(@dia.fecha, @dia.fecha)

		if @dia.produccionMasa.nil?
			flash[:error] = "Aun no se ingresaro la Produccion de Masas Cocidas para este dia"
			redirect_to escritorio_path
		else
			add_breadcrumb "Editar Produccion Masas Cocidas", editar_insumo_diario_path(@dia.fecha)
			@produccionMasa = @dia.produccionMasa
			@title = 'Editar Produccion Masas Cocidas'
		end
	end

	def update
		@produccionMasa = ProduccionMasa.find(params[:id])
		if @produccionMasa.update_attributes(params[:produccion_masa])
			flash[:success] = "Produccion Masas Cocidas correctamente actualizadas"
			redirect_to ver_dia_path(@produccionMasa.dia.fecha)
		else
			add_breadcrumb "Editar Produccion Masas Cocidas", editar_insumo_diario_path(@produccionMasa.dia.fecha)
			@title = "Editar Produccion Masas Cocidas"
			render 'edit'
		end
	end

	def validar
	        produccionMasa = ProduccionMasa.find(params[:id]) if params[:id] != '0'
		produccionMasa = ProduccionMasa.new if produccionMasa.nil?
                dia = Dia.find(params[:dia])
		produccionMasa[params[:nombre]] = params[:valor]
		produccionMasa.dia = dia
		if produccionMasa.valid?
			mensaje = "OK"
		else
			mensaje = produccionMasa.errors[params[:nombre]]
		end

		render :json => {:mensaje => mensaje}
	end

end
