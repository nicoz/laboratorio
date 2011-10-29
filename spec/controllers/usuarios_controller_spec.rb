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
	
	describe "GET 'show'" do
		before(:each) do
			@usuario = Factory(:usuario)
		end
		
		it "deberia ser correcto" do
			get :show, :id => @usuario
			response.should be_success
		end
		
		it "deberia encontrar el usuario correcto" do
			get :show, :id => @usuario
			assigns(:usuario).should == @usuario
		end
		
		it "deberia tener el titulo correcto" do
			get :show, :id => @usuario
			response.should have_selector("title", :content => @usuario.nombre)
		end
		
		it "deberia incluir el nombre del usuario" do
			get :show, :id => @usuario
			response.should have_selector("h1", :content => @usuario.nombre)
		end
	end

end
