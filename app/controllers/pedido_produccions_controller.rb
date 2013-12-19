class PedidoProduccionsController < ApplicationController
  before_filter :autenticar, 		:only => [:create, :new,:edit, :update, :show]
	before_filter :validar_turno_dia,	:only => [:new, :edit]
	before_filter :solo_reportes
	before_filter :zafra_abierta, :only => [:new, :edit]
	add_breadcrumb 'Escritorio', '/escritorio'

	def show
		fecha = Date.parse(params[:fecha])
		@dia = Dia.find_by_fecha(fecha)

		if @dia.pedido_produccion.nil?
			flash[:error] = "Aun no se ingreso el pedido"
			redirect_to escritorio_path
		end
	end

	def new
		fecha = Date.parse(params[:fecha])
		@dia_origen = Dia.find_or_create_by_fecha(fecha)
    @zafra = Zafra.where('dia_inicio <= ? and (dia_fin >= ? or dia_fin is null)', @dia_origen.fecha, @dia_origen.fecha).first
    
    @dia = Dia.find_or_create_by_fecha(@zafra.dia_inicio)
    
		add_breadcrumb "#{l @dia.fecha}", ver_dia_path(@dia.fecha, @dia.fecha)

		if @dia.pedido_produccion.nil?
			add_breadcrumb "Crear Pedido de Produccion", crear_pedido_produccion_path(@dia.fecha)
			@pedido_produccion = PedidoProduccion.new
			Cliente.where(:habilitado => true).order('orden').each do |cliente|
			  pedido_produccion_cliente = ClientePedidoProduccion.new(:cliente => cliente, :pedido_produccion => @pedido_produccion)
			  @pedido_produccion.clientes << pedido_produccion_cliente
			end
			@dia.pedido_produccion = @pedido_produccion
			@title = "Crear Pedido de Produccion #{l @zafra.dia_inicio}" 
		else
			add_breadcrumb "Editar Pedido de Produccion", editar_pedido_produccion_path(@dia.fecha)
			@pedido_produccion = @dia.pedido_produccion
			@title = "Editar Pedido de Produccion - Zafra #{l @zafra.dia_inicio}" 
			render 'edit'
		end
	end

	def create
	  Rails.logger.info '=================== PEDIDO PRODUCCION CREATE ==================='
	  Rails.logger.info params
	  @dia = Dia.find_or_create_by_fecha(params[:dia][:fecha])
	  @dia_origen = Dia.find_or_create_by_fecha(params[:dia_origen][:fecha])
	  @pedido_produccion = @dia.pedido_produccion
		#@pedido_produccion = PedidoProduccion.new(params[:pedido_produccion])
    # :paquetesPapel, :paquetesPolietileno ,
    # :industriaBolsas, :bolsasAzucarlito, :bigBagAzucarlito,
    # :bigBagDnd
    @pedido_produccion.paquetesPapel = params[:pedido_produccion][:paquetesPapel]
    @pedido_produccion.paquetesPolietileno = params[:pedido_produccion][:paquetesPolietileno]
    @pedido_produccion.industriaBolsas = params[:pedido_produccion][:industriaBolsas]
    @pedido_produccion.bolsasAzucarlito = params[:pedido_produccion][:bolsasAzucarlito]
    @pedido_produccion.bigBagAzucarlito = params[:pedido_produccion][:bigBagAzucarlito]
    @pedido_produccion.bigBagDnd = params[:pedido_produccion][:bigBagDnd]
    
		
		if @pedido_produccion.save
      Cliente.where(:habilitado => true).order('orden').each do |cliente|
  		  pedido_produccion_cliente = ClientePedidoProduccion.find_or_create_by_cliente_id_and_pedido_produccion_id(cliente.id, @pedido_produccion.id)
  		  pedido_produccion_cliente.azucar_big_bag = params[:pedido_produccion][:cliente]["#{cliente.id}"][:azucar_big_bag]
  		  pedido_produccion_cliente.save()
  		end

			flash[:success] = "Pedido de Produccion correctamente creado"
			redirect_to ver_dia_path(@dia_origen.fecha)
		else
			@dia = @pedido_produccion.dia
			flash[:error] = "Errores al crear el Pedido de Produccion"
			add_breadcrumb "Crear Pedido Produccion", crear_pedido_produccion_path(@pedido_produccion.dia.fecha)
			@title = "Crear Pedido de Producion - Zafra #{l @zafra.dia_inicio}" 
			render 'new'
		end
	end

	def edit
	 
		fecha = Date.parse(params[:fecha])
		@dia = Dia.find_or_create_by_fecha(fecha)

		add_breadcrumb "#{l @dia.fecha}", ver_dia_path(@dia.fecha, @dia.fecha)

		if @dia.pedido_produccion.nil?
			flash[:error] = "Aun no se ingreso el Pedido de Produccion para esta Zafra"
			redirect_to escritorio_path
		else
			add_breadcrumb "Editar Pedido de Produccion", editar_pedido_produccion_path(@dia.fecha)
			@pedido_produccion = @dia.pedido_produccion
			@title = "Editar Pedido de Produccion - Zafra #{l @zafra.dia_inicio}" 
		end
	end

	def update
	  Rails.logger.info '=================== PEDIDO PRODUCCION UPDATE ==================='
    Rails.logger.info params
		@pedido_produccion = PedidoProduccion.find(params[:id])
		if @pedido_produccion.update_attributes(params[:pedido_produccion])
			flash[:success] = "Pedido Produccion correctamente actualizado"
			redirect_to ver_dia_path(@pedido_produccion.dia.fecha)
		else
			add_breadcrumb "Editar Pedido Produccion", editar_pedido_produccion_path(@dia.fecha)
			@title = "Editar Pedido Produccion - Zafra #{l @zafra.dia_inicio}" 
			render 'edit'
		end
	end

	def validar
    pedido_produccion = PedidoProduccion.find(params[:id]) if params[:id] != '0'
		pedido_produccion = PedidoProduccion.new if pedido_produccion.nil?
    dia = Dia.find(params[:dia])
		pedido_produccion[params[:nombre]] = params[:valor]
		pedido_produccion.dia = dia
		if pedido_produccion.valid?
			mensaje = "OK"
		else
			mensaje = pedido_produccion.errors[params[:nombre]]
		end

		render :json => {:mensaje => mensaje}
	end
end
