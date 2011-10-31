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
	
	describe "POST 'create'" do
		describe "fallar" do
			
			before(:each) do
				@attr = { :nombre => "", :email => "", :password => "",
					:password_confirmation => ""}
			end
			
			it "no deberia crear un usaurio" do
				lambda do
					post :create, :usuario => @attr
				end.should_not change(Usuario, :count)
			end
			
			it "deberia tener el nombre correcto" do
				post :create, :usuario => @attr
				response.should have_selector("title", :content => "Crear Usuario")
			end
			
			it "deberia renderizar la pagina 'Crear usuario'" do
				post :create, :usuario => @attr
				response.should render_template('new')
			end
		end
		
		describe "guardar bien" do
		
		
			before(:each) do
				@attr = { :nombre => "Nuevo Usuario", :email => "nuevo@usuario.com", :password => "foobar", :password_confirmation => "foobar"}
			end
			
			it "deberia crear un nuevo usuario" do
				lambda do
					post :create, :usuario => @attr
				end.should change(Usuario, :count).by(1)
			end
			
			it "deberia redirigir a la pagina 'ver' de ese usuario" do
				post :create, :usuario => @attr
				response.should redirect_to(usuario_path(assigns(:usuario)))
			end
			
			it "deberia dar un mensaje de usuario correctamente creado" do
				post :create, :usuario => @attr
				flash[:success].should =~ /Usuario correctamente creado/i
			end
		end
	end

end
