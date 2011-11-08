require 'spec_helper'

describe UsuariosController do
	render_views
	
	describe "Get 'index'" do
	
		describe "para usuarios no ingresados al sistema" do
			
			it "deberia negar el acceso" do
				get :index
				response.should redirect_to(ingresar_path)
				flash[:notice].should =~ /ingrese/i
			end
		end
		
		describe "para usuarios ingresados al sistema que no son administradores" do
			before(:each) do
				@usuario = test_ingresar(Factory(:usuario))
			end
			
			it "deberia negar el acceso" do
				get :index
				response.should redirect_to(root_path)
			end
		end
		
		describe "para usuarios administradores que ya ingresaron al sistema" do
			
			before(:each) do
				@usuario = test_ingresar(Factory(:usuario, :admin => true))
				segundo = Factory(:usuario, :nombre => "Bob", :email => "otro@ejemplo.com")
				tercero = Factory(:usuario, :nombre => "Ben", :email => "otro@ejemplo.net")
				@usuarios = [@usuario, segundo, tercero]
				
				30.times do 
					@usuarios << Factory(:usuario, :email => Factory.next(:email))
				end
			end
			
			it "deberia ser correcto" do
				get :index
				response.should be_success
			end
			
			it "deberia tener el titulo correcto" do
				get :index
				response.should have_selector("title", :content => "Listado de Usuarios")
			end
			
			it "deberia tener un elemento por cada usuario" do
				get :index
				@usuarios[0..2].each do |usuario|
					response.should have_selector("li", :content => usuario.nombre)
				end
			end
			
			it "deberia paginar usuarios" do
				get :index
				response.should have_selector("div.pagination")
				response.should have_selector("span.disabled", :content => "Previous")
				response.should have_selector("a", :href => "/usuarios?page=2",
								   :content => "2")
			   	response.should have_selector("a", :href => "/usuarios?page=2",
			   					   :content => "Next")
			end
		end
	end
	
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
	
	describe "Get 'edit'" do
	
		describe "para no administradores" do
			before(:each) do
				@usuario = Factory(:usuario)
				@otroUsuario = Factory(:usuario, :email => Factory.next(:email))
				test_ingresar(@usuario)
			end
		
			it "deberia ser correcto" do
				get :edit, :id => @usuario
				response.should be_success
			end
		
			it "deberia tener el titulo correcto" do
				get :edit, :id => @usuario
				response.should have_selector("title", :content => "Editar Usuario")
			end
		
			it "no deberia editar el perfil de otro usuario" do
				get :edit, :id => @otroUsuario
				response.should redirect_to(root_path)
			end
		end
	
	end
	
	describe "PUT 'update'" do
	
		before(:each) do
			@usuario = Factory(:usuario)
			test_ingresar(@usuario)
		end
		
		describe "fallar" do
			
			before(:each) do
				@attr = { :email => "", :nombre => "", :password => "", 
					  :password_confirmation => "" }
			end
			
			it "deberia volver a renderizar la pagina de editar usuario" do
				put :update, :id => @usuario, :usuario => @attr
				response.should render_template('edit')
			end
			
			it "deberia tener el titulo correcto" do
				put :update, :id => @usuario, :usuario => @attr
				response.should have_selector("title", :content => "Editar Usuario")
			end
		end
		
		describe "exito" do
		
			before(:each) do
				@attr = { :email => "usuario@ejemplo.com", :nombre => "Nuevo Nombre", :password => "barbaz", :password_confirmation => "barbaz" }
			end
			
			it "deberia cambiar los atributos del usuario" do
				put :update, :id => @usuario, :usuario => @attr
				@usuario.reload
				@usuario.nombre.should == @attr[:nombre]
				@usuario.email.should == @attr[:email]
			end
			
			it "deberia redirigir a la pagina de mostrar el usuario" do
				put :update, :id => @usuario, :usuario => @attr
				response.should redirect_to(usuario_path(@usuario))
			end
			
			it "deberia mostrar un mensaje flash" do
				put :update, :id => @usuario, :usuario => @attr
				flash[:success].should =~ /modificado/
			end
		end
	end
	
	describe "autorizando usuarios para acceder a edit/update" do
	
	
		before(:each) do
			@usuario = Factory(:usuario)
			@admin = Factory(:usuario, :admin => true, :email => Factory.next(:email))
		end
		
		describe "para usuarios que no han ingresado al sistema" do
		
			it "deberia negar acceso a la pagina 'edit'" do
				get :edit, :id => @usuario
				response.should redirect_to(ingresar_path)
			end
			
			it "deberia negar acceso a 'update'" do
				put :update, :id => @usuario, :usuario => {}
				response.should redirect_to(ingresar_path)
			end
		end
		
		describe "para usuarios que han ingresado al sistema" do
			
			before(:each) do
				usuario_erroneo = Factory(:usuario, :email => "ejemplo@usuario.net")
				test_ingresar(usuario_erroneo)
			end
			
			it "deberia requerir usuarios iguales para 'edit'" do
				get :edit, :id => @usuario
				response.should redirect_to(root_path)
			end
			
			it "deberia requerir usuarios iguales para 'update'" do
				put :update, :id => @usuario, :usuario => {}
				response.should redirect_to(root_path)
			end
		end
		
		describe "para usuarios administradores que han ingresado al sistema" do
			
			before(:each) do
				test_ingresar(@admin)
			end
			
			it "deberia perimitir editar" do
				get :edit, :id => @usuario
				response.should render_template('edit')
			end
			
			it "deberia permitir hacer 'update'" do
				put :update, :id => @usuario, :usuario => {}
				response.should be_success
			end
		end
		
	end 
	
	describe "DELETE 'destroy'" do
	
		before(:each) do
			@usuario = Factory(:usuario)
		end	
		
		describe "como un usuario no ingresado al sistema" do
			
			it "deberia negar el acceso" do
				delete :destroy, :id => @usuario
				response.should redirect_to(ingresar_path)
			end
			
		end
		
		describe "como un usuario no administrador" do
			
			it "deberia protejer esta pagina" do
				test_ingresar(@usuario)
				delete :destroy, :id => @usuario
				response.should redirect_to(root_path)
			end
		end
		
		describe "como un usuario administrador" do
		
			before(:each) do
				admin = Factory(:usuario, :email => "admin@ejemplo.com", :admin => true)
				test_ingresar(admin)
			end
			
			it "deberia destruir al usuario" do
				lambda do
					delete :destroy, :id => @usuario
				end.should change(Usuario, :count).by(-1)
			end
			
			it "deberia redirigir a la pagina de usuarios" do
				delete :destroy, :id => @usuario
				response.should redirect_to(usuarios_path)
			end
		end
	end

end
