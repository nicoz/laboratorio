require 'spec_helper'

describe "LayoutLinks" do
  

	it "Deberia tener una pagina Acerca en '/acerca'" do
		get '/acerca'
		response.should have_selector('title', :content => "Acerca de")
	end
	
	it "Deberia tener una pagina Ayuda en '/ayuda'" do
		get '/ayuda'
		response.should have_selector('title', :content => "Ayuda")
	end
	
	
	describe "cuando no haya ingresado" do
		it "deberia tener un formulario de ingreso" do
			visit '/'
			response.should have_selector("form", :action => '/sessions')
		end
	end
	
	describe "cuando haya ingresado" do
		
		before(:each) do
			@usuario = Factory(:usuario)
			visit '/'
			fill_in :email,		:with => @usuario.email
			fill_in :password,	:with => @usuario.password
			click_button 'Ingresar'
		end
		
		it "deberia tener un link para salir del sistema" do
			visit root_path
			response.should have_selector("button", :content => 'Salir')
		end

		it "deberia tener un link para ir al escritorio de trabajo" do
			visit root_path
			response.should have_selector("a", :href => escritorio_path,
							:content => "Escritorio"
			)
		end
		
		it "no deberia tener un link para ir al inicio" do
			visit root_path
			response.should_not have_selector("a", :href => root_path,
							:content => "Inicio"
			)
		end

		it "deberia tener un link para editar el perfil" do
			visit root_path
			response.should have_selector("a", :href => usuario_path(@usuario),
							   :content => "Cuenta")
		end
		
		describe "cuando sea admin" do
			
			before(:each) do
				@usuario.toggle!(:admin)
			end
			
			it "deberia tener un link para ver la lista de usuarios" do
				visit root_path
				response.should have_selector("a", :href => usuarios_path,
								   :content => "Usuarios")
			end

			it "deberia tener un link para crear usuarios en su escritorio de trabajo" do
				visit escritorio_path
				response.should have_selector("a", :href => crearusuario_path,
								:content => "Crear Usuario"
				)
			end

			it "deberia tener un link para trabajar con usuarios en su escritorio de trabajo" do
				visit escritorio_path
				response.should have_selector("a", :href => usuarios_path,
								:content => "Trabajar con Usuarios"
				)
			end
			
			it "Deberia tener una pagina de creacion de usuarios en '/crearusuario'" do
				get '/crearusuario'
				response.should have_selector("title", 
						:content => "Crear Usuario")
			end

			it "Deberia tener un link para crear usuarios en la vista index de usuarios" do
				visit usuarios_path
				response.should have_selector("a", :href => crearusuario_path,
								:content => "Crear Usuario"
				)
			end
		end
	end
end
