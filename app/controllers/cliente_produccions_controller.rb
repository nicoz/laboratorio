class ClienteProduccionsController < ApplicationController
  before_filter :solo_reportes
  before_filter :zafra_abierta, :only => [:new, :edit, :create, :update, :destroy]

  def validar
    cliente_produccion = ClienteProduccion.new
    cliente = Cliente.find(params[:cliente]) unless params[:cliente] == '0'
    cliente = Cliente.new if cliente.nil?

    produccion = Produccion.find(params[:produccion]) unless params[:produccion] == '0'
    produccion = Produccion.new if produccion.nil?

    cliente_produccion[params[:nombre]] = params[:valor]
    cliente_produccion.cliente_id = cliente.id
    cliente_produccion.produccion_id = produccion.id

    if cliente_produccion.valid?
      mensaje = "OK"
    else
      mensaje = cliente_produccion.errors[params[:nombre]]
    end

    render :json => {:mensaje => mensaje}
  end


  def index
    fecha = Date.parse(params[:fecha])
    @dia = Dia.find_by_fecha(fecha)
    if @dia.nil?
      @dia = Dia.new(:fecha => fecha)
    end

    @cliente = ClienteProduccion.new

    add_breadcrumb "#{l @dia.fecha}", ver_dia_path(@dia.fecha, @dia.fecha)

    turnos = Turno.find(:all, :order => 'orden', :conditions => ["habilitado =?", true])

    clientes = Cliente.find(:all, :order => 'orden', :conditions => ["habilitado =?", true])
    @activos = clientes

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
      @title = "Clientes del dia"
      add_breadcrumb 'Clientes del dia', cliente_produccion_path
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
      @clientes = @dia.turnos.first.produccion.clientes
      @dia.save()
      add_breadcrumb 'Clientes del dia', cliente_produccion_path

      @title = "Clientes del dia"
    end
  end

  def create
    dia = Dia.find(params[:cliente_produccion][:dia_id])
    cliente = Cliente.find(params[:cliente_produccion][:cliente_id])
    todo_ok = true
    hay_sin_cliente = false

    turnos = dia.turnos
    turnos.each do |turno|
      produccion = turno.produccion
      ya_existe = false
      produccion.clientes.each do |cp|
        ya_existe = cp.cliente.nombre == cliente.nombre
      end
      if !ya_existe
        cliente_produccion = ClienteProduccion.new
        cliente_produccion.produccion = produccion
        cliente_produccion.cliente = cliente
        hay_sin_cliente = true
        if !cliente_produccion.save
          todo_ok = false
        end
      end
    end
    if todo_ok and hay_sin_cliente
      flash[:success] = "#{cliente.nombre} correctamente agregado para el dia #{l dia.fecha}"
    else
      if !hay_sin_cliente
        flash[:error] = "El cliente existe en todos los turnos."
      else
        flash[:error] = "Ocurrio un error al ingresar el cliente"
      end
    end

    redirect_to cliente_produccion_path(dia.fecha)
  end

  def destroy
    cliente_produccion = ClienteProduccion.find(params[:id])
    cliente_borrable = cliente_produccion.cliente.id
    fecha = Date.parse(params[:fecha])
    dia = Dia.find_by_fecha(fecha)
    turnos = dia.turnos

    turnos.each do |turno|
      turno.produccion.clientes.each do |cliente|
        cliente.destroy if cliente.cliente.id == cliente_borrable
        flash[:success] = "Cliente del dia destruido."
      end
    end

    redirect_to cliente_produccion_path(dia.fecha)
  end
end
