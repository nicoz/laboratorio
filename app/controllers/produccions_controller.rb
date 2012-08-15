class ProduccionsController < ApplicationController
	before_filter :autenticar, 		:only => [:index, :edit, :update, :destroy, :create, :new, :show]
	before_filter :validar_turno_dia,	:only => [:new, :edit]
	before_filter :solo_reportes
	before_filter :zafra_abierta, :only => [:new, :edit]
	add_breadcrumb 'Escritorio', '/escritorio'

	def index
		add_breadcrumb 'Producciones', turnos_path
		@title = "Producciones"
		@search = Produccion.search(params[:search])
		@producciones = @search.paginate(:page => params[:page], :per_page => 10, :order => 'created_at')
		@busqueda = params[:search]
	end

	def show
		@produccion = Produccion.find(params[:id])
		@title = "#{@produccion.turno_dia.turno.nombre} #{l @produccion.turno_dia.dia.fecha}"
		add_breadcrumb 'Producciones', turnos_path
		add_breadcrumb @produccion.turno_dia.turno.nombre, @produccion
	end

	def new
		fecha = Date.parse(params[:fecha])
		@dia = Dia.find_by_fecha(fecha)
		if @dia.nil?
			@dia = Dia.new(:fecha => fecha)
		end

		add_breadcrumb "#{l @dia.fecha}", ver_dia_path(@dia.fecha, @dia.fecha)

		turnos = Turno.find(:all, :order => 'orden', :conditions => ["habilitado =?", true])

		clientes = Cliente.find(:all, :order => 'orden', :conditions => ["habilitado =?", true])

		#creo los turnos para el dia
		if @dia.turnos.empty?
			turnos.each do |turno|
				td = TurnoDia.new
				td.turno = turno
				td.dia = @dia
				#creo una produccion para cada turno
				produccion = Produccion.new
				produccion.turnoDia = td
				clientes.each do |cliente|
					cliente_produccion = ClienteProduccion.new
					cliente_produccion.produccion = produccion
					cliente_produccion.cliente = cliente
					produccion.clientes << cliente_produccion
				end
				td.produccion = produccion
				@dia.turnos << td
			end
			@title = "Crear Produccion"
			add_breadcrumb 'Crear Produccion', produccions_path
		else
			@dia.turnos.each do |turno|
			        turnos.delete(turno.turno)
				if turno.produccion.nil?
					produccion = Produccion.new
					produccion.turnoDia = turno
					clientes.each do |cliente|
						cliente_produccion = ClienteProduccion.new
						cliente_produccion.produccion = produccion
						cliente_produccion.cliente = cliente
						produccion.clientes << cliente_produccion
					end
					turno.produccion = produccion
				end
			end

			turnos.each do |turno|
				td = TurnoDia.new
				td.turno = turno
				td.dia = @dia
				#creo una produccion para cada turno
				produccion = Produccion.new
				produccion.turnoDia = td
				clientes.each do |cliente|
					cliente_produccion = ClienteProduccion.new
					cliente_produccion.produccion = produccion
					cliente_produccion.cliente = cliente
					produccion.clientes << cliente_produccion
				end
				td.produccion = produccion
				@dia.turnos << td
			end
			@dia.turnos.sort! { |a,b| a.turno.orden <=> b.turno.orden }
			add_breadcrumb 'Editar Produccion', produccions_path
			@title = "Editar Produccion"
			render 'edit'
		end
	end

	def create
		@title = 'Crear Produccion'
		@dia = Dia.find_or_create_by_fecha(params[:dia][:fecha])
		valido = true
		turnos = Turno.find(:all, :conditions => ["habilitado =?", true])
		clientes = Cliente.find(:all, :conditions => ["habilitado =?", true])
		turnos.each do |turno|
			turnoDia = TurnoDia.find_or_create_by_dia_id_and_turno_id(@dia, turno.id)
			turnoDia.turno = turno
			produccion = Produccion.find_or_create_by_turnoDia_id(turnoDia.id)
			produccion.paquetesPapel = params[:turno][turno.id.to_s][:paquetesPapel]
			produccion.paquetesPolietileno = params[:turno][turno.id.to_s][:paquetesPolietileno]
			produccion.melaza = params[:turno][turno.id.to_s][:melaza]
			produccion.rubio = params[:turno][turno.id.to_s][:rubio]
			produccion.industriaBolsas = params[:turno][turno.id.to_s][:industriaBolsas]
			produccion.bolsasAzucarlito = params[:turno][turno.id.to_s][:bolsasAzucarlito]
			produccion.bigBagAzucarlito = params[:turno][turno.id.to_s][:bigBagAzucarlito]
			produccion.bigBagDnd = params[:turno][turno.id.to_s][:bigBagDnd]
			produccion.turnoDia = turnoDia

			clientes.each do |cliente|
				cliente_produccion = ClienteProduccion.find_or_create_by_cliente_id_and_produccion_id(cliente.id, produccion.id)
				cliente_produccion.azucar_big_bag = params[:turno][turno.id.to_s][:cliente][cliente.id.to_s][:azucar_big_bag]
				if cliente_produccion.valid?
					produccion.clientes << cliente_produccion
				else
					valido = false
					flash[:error] = 'Error al procesar datos del cliente'
				end
			end

			if produccion.save
				turnoDia.produccion = produccion
				@dia.turnos << turnoDia
			else
				flash[:error] = 'Error al procesar los datos'
				valido = false
			end
		end

		if valido
		        flash[:success] = 'Producciones guardadas'
		        redirect_to ver_dia_path(@dia.fecha)
		else
		        flash[:error] = 'Errores al guardar la produccion'
		        @dia.turnos.sort! { |a,b| a.turno.orden <=> b.turno.orden }
		        render 'new'
		end
	end

	def edit
		turno = TurnoDia.find(params[:turno])
		add_breadcrumb "#{turno.turno.nombre} #{l turno.dia.fecha}", ver_turno_dia_path(turno.dia.fecha, turno.turno.nombre)
		@produccion = Produccion.find_by_turnoDia_id(params[:turno])
		@title = "Editar Produccion"
		add_breadcrumb 'Editar Produccion', producciones_path
	end

	def update
		@produccion = Produccion.find(params[:id])
		turno = TurnoDia.find(params[:produccion][:turnoDia_id])
		if @produccion.update_attributes(params[:produccion])
			flash[:success] = "Produccion modificada"
			redirect_to ver_turno_dia_path(turno.dia.fecha, turno.turno.nombre)
		else
			@title = "Editar Produccion"
			render 'edit'
		end
	end

	def destroy
		#se destruyen?
	end

	def validar
		produccion = Produccion.find(params[:produccion]) unless params[:produccion] == '0'
		produccion = Produccion.new if produccion.nil?

		produccion[params[:nombre]] = params[:valor]
		produccion.turnoDia_id = params[:turno]
		if produccion.valid?
			mensaje = "OK"
		else
			mensaje = produccion.errors[params[:nombre]]
		end

		render :json => {:mensaje => mensaje}
	end
end
