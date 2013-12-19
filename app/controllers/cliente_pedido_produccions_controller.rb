class ClientePedidoProduccionsController < ApplicationController
  before_filter :solo_reportes
  before_filter :zafra_abierta, :only => [:new, :edit]

  def validar
    cliente_pedido_produccion = ClientePedidoProduccion.new
    cliente = Cliente.find(params[:cliente]) unless params[:cliente] == '0'
    cliente = Cliente.new if cliente.nil?

    pedido_produccion = PedidoProduccion.find(params[:produccion]) unless params[:produccion] == '0'
    pedido_produccion = PedidoProduccion.new if pedido_produccion.nil?

    cliente_pedido_produccion[params[:nombre]] = params[:valor]
    cliente_pedido_produccion.cliente_id = cliente.id
    cliente_pedido_produccion.pedido_produccion_id = pedido_produccion.id

    if cliente_pedido_produccion.valid?
      mensaje = "OK"
    else
      mensaje = cliente_pedido_produccion.errors[params[:nombre]]
    end

    render :json => {:mensaje => mensaje}
  end
end
