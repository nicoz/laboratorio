require 'spec_helper'

describe UsuariosController do
	render_views
	
	before(:each) do
		@titulo = "Sistema de gestion integral de laboratorio |"
	end
	
	describe "GET 'new'" do
		it "should be successful" do
			get 'new'
			response.should be_success
		end
		
		it "Deberia tener el titulo correcto" do
			get 'new'
			response.should have_selector("title", 
					:content => "#{@titulo} Crear Usuario")
		end

	end

end
