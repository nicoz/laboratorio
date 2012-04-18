class ClienteProduccionsController < ApplicationController

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
end
