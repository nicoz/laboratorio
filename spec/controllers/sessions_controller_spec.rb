require 'spec_helper'

describe SessionsController do
	render_views
	
	describe "GET 'new'" do
		it "deberia ser correcto" do
			get :new
			response.should be_success
		end
		
		it "deberia tener el titulo correcto" do
			get :new
			response.should have_selector("title", :content => "Ingreso")
		end
	end
	
	describe "POST 'create'" do
	
		describe "ingreso invalido" do
		
			before(:each) do
				@attr = { :email => "email@example.com", :password => "invalida" }
			end
			
			it "deberia volver a renderizar la pagina" do
				post :create, :session => @attr
				response.should render_template('new')
			end
			
			it "deberia tener el titulo correcto" do
				post :create, :session => @attr
				response.should have_selector("title", :content => "Ingreso")
			end
			
			it "deberia tener un mensaje de flash.now" do
				post :create, :session => @attr
				flash.now[:error].should =~ /invalida/i
			end
		end
		
		describe "con email y clave validos" do
			
			before(:each) do
				@usuario = Factory(:usuario)
				@attr = { :email => @usuario.email, :password => @usuario.password }
			end
			
			it "deberia permitir que el usuario ingresara" do
				post :create, :session => @attr
				#completar con test para probar el correcto ingreso
				controller.usuario_actual.should == @usuario
				controller.should be_ingresado
			end
			
			it "deberia redirijir a el escritorio de trabajo" do
				post :create, :session => @attr
				response.should redirect_to(escritorio_path(@usuario))
			end
		end
	end
	
	describe "DELETE 'destroy'" do
	
	
		it "el usuario deberia salir del sistema" do
			test_ingresar(Factory(:usuario))
			delete :destroy
			controller.should_not be_ingresado
			response.should redirect_to(root_path)
		end
	end

end
