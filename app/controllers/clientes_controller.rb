class ClientesController < ApplicationController
	before_filter :autenticar,	:only => [:index, :edit, :update, :destroy, :create, :new, :show]
	before_filter :usuario_admin,	:only => [:index, :edit, :update, :destroy, :create, :new, :show]
	before_filter :solo_reportes
	add_breadcrumb 'Escritorio', '/escritorio'

	def index
		add_breadcrumb 'Clientes', clientes_path
		@title = "Turnos"
		@search = Cliente.search(params[:search])
		@clientes = @search.paginate(:page => params[:page], :per_page => 10, :order => 'orden')
		@busqueda = params[:search]
	end

	def show
		@cliente = Cliente.find(params[:id])
		@title = @cliente.nombre
		add_breadcrumb 'Clientes', clientes_path
		add_breadcrumb @cliente.nombre, @cliente
	end

	def new
		add_breadcrumb 'Clientes', turnos_path
		add_breadcrumb 'Crear Cliente', turnos_path
		@title = "Crear Cliente"
		@cliente = Cliente.new
	end

	def create
		@cliente = Cliente.new(params[:cliente])
		if @cliente.save
			flash[:success] = "Cliente correctamente creado"
			redirect_to @cliente
		else
			@title = "Crear Cliente"
			render 'new'
		end
	end

	def edit
		@cliente = Cliente.find(params[:id])
		@title = "Editar Cliente"
		add_breadcrumb 'Clientes', turnos_path
		add_breadcrumb @cliente.nombre, edit_cliente_path(@cliente)
	end

	def update
		@cliente = Cliente.find(params[:id])
		if @cliente.update_attributes(params[:cliente])
			flash[:success] = "Cliente modificado"
			redirect_to @cliente
		else
			@title = "Editar Cliente"
			render 'edit'
		end
	end

	def destroy
		cliente = Cliente.find(params[:id])
		producciones = 1
		#producciones = Produccion.find_by_turno_id(cliente).count
		if producciones > 0
			if cliente.destroy
				flash[:success] = "Cliente destruido."
			else
				flash[:error] = "No se pudo eliminar el cliente"
			end
		else
			flash[:error] = "No se puede eliminar un cliente que haya sido usado en el pasaje de datos. Marquelo como deshabilitado."
		end
		redirect_to clientes_path
	end
end
