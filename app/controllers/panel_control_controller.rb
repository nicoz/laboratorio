class PanelControlController < ApplicationController

	def show
		@producciones = Produccion.all 
	end

end
