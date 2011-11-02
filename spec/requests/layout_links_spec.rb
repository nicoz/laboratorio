require 'spec_helper'

describe "LayoutLinks" do
  
	it "Deberia tener una pagina de Inicio en '/'" do
		get '/'
		response.should have_selector('title', :content => "Inicio")
	end
	
	it "Deberia tener una pagina Acerca en '/acerca'" do
		get '/acerca'
		response.should have_selector('title', :content => "Acerca de")
	end
	
	it "Deberia tener una pagina Ayuda en '/ayuda'" do
		get '/ayuda'
		response.should have_selector('title', :content => "Ayuda")
	end
	
	it "Deberia tener una pagina de creacion de usuarios en '/crearusuario'" do
		get '/crearusuario'
		response.should have_selector("title", 
				:content => "Crear Usuario")
	end
	
	describe "cuando no haya ingresado" do
		it "deberia tener un link para ingresar" do
			visit root_path
			response.should have_selector("a", :href => ingresar_path,
							   :content => "Ingresar")
		end
	end
	
	describe "cuando haya ingresado" do
		
		before(:each) do
			@usuario = Factory(:usuario)
			visit ingresar_path
			fill_in :email,		:with => @usuario.email
			fill_in :password,	:with => @usuario.password
			click_button
		end
		
		it "deberia tener un link para salir del sistema" do
			visit root_path
			response.should have_selector("a", :href => salir_path,
							   :content => "Salir")
		end
		
		it "deberia tener un link para editar el perfil" do
			visit root_path
			response.should have_selector("a", :href => usuario_path(@usuario),
							   :content => "Cuenta")
		end
	end
end
