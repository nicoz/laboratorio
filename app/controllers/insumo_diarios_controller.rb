class InsumoDiariosController < ApplicationController
	before_filter :autenticar, 		:only => [:create, :new,:edit, :update, :show]
	before_filter :validar_turno_dia,	:only => [:new, :edit]
	add_breadcrumb 'Escritorio', '/escritorio'
	
	def show
		fecha = Date.parse(params[:fecha])
		@dia = Dia.find_by_fecha(fecha)
		
		if @dia.insumoDiario.nil?
			flash[:error] = "Aun no se ingreso el insumo diario"
			redirect_to escritorio_path
		end
	end
	
	def new
		fecha = Date.parse(params[:fecha])
		@dia = Dia.find_or_create_by_fecha(fecha)
		
		add_breadcrumb "#{l @dia.fecha}", ver_dia_path(@dia.fecha, @dia.fecha)
		
		if @dia.insumoDiario.nil?
			add_breadcrumb "Crear Insumo Diario", crear_insumo_diario_path(@dia.fecha)
			@insumoDiario = InsumoDiario.new
			@insumoDiario.default #cargo valores en cero
			@title = 'Crear Insumo Diario'
		else
			add_breadcrumb "Editar Insumo Diario", editar_insumo_diario_path(@dia.fecha)
			@insumoDiario = @dia.insumoDiario
			@title = 'Editar Insumo Diario'
			render 'edit'
		end
	end
	
	def create
		@insumo = InsumoDiario.new(params[:insumo_diario])
		if @insumo.save
			flash[:success] = "Insumo Diario correctamente creado"
			redirect_to ver_dia_path(@insumo.dia.fecha)
		else
			add_breadcrumb "Crear Insumo Diario", crear_insumo_diario_path(@dia.fecha)
			@title = "Crear Insumo Diario"
			render 'new'
		end
	end
	
	def edit
		fecha = Date.parse(params[:fecha])
		@dia = Dia.find_or_create_by_fecha(fecha)
		
		add_breadcrumb "#{l @dia.fecha}", ver_dia_path(@dia.fecha, @dia.fecha)
		
		if @dia.insumoDiario.nil?
			flash[:error] = "Aun no se ingreso Insumo Diario para este dia"
			redirect_to escritorio_path
		else
			add_breadcrumb "Editar Insumo Diario", editar_insumo_diario_path(@dia.fecha)
			@insumoDiario = @dia.insumoDiario
			@title = 'Editar Insumo Diario'
		end
	end
	
	def update
		@insumo = InsumoDiario.find(params[:id])
		if @insumo.update_attributes(params[:insumo_diario])
			flash[:success] = "Insumo Diario correctamente actualizado"
			redirect_to ver_dia_path(@insumo.dia.fecha)
		else
			add_breadcrumb "Editar Insumo Diario", editar_insumo_diario_path(@dia.fecha)
			@title = "Editar Insumo Diario"
			render 'edit'
		end
	end

end
