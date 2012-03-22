require 'spec_helper'

describe "Usuarios" do

  describe "crear usuarios" do

	before(:each) do
			@usuario = Factory(:usuario, :admin => true)
			visit '/'
			fill_in :email,		:with => @usuario.email
			fill_in :password,	:with => @usuario.password
			click_button 'Ingresar'
	end
	
    describe "fallar" do

      it "No deberia crear un nuevo usuario" do
      	lambda do
		visit crearusuario_path
		fill_in "Nombre",         :with => ""
		fill_in "Email",        :with => ""
		fill_in "Clave",     :with => ""
		fill_in "Confirmacion", :with => ""
		click_button 'Crear'
		response.should render_template('usuarios/new')
	end.should_not change(Usuario, :count)
      end
    end
    
    describe "guardar correctamente" do

      it "deberia crear un nuevo usuario" do
        lambda do
          visit crearusuario_path
          fill_in "Nombre",         :with => "Testing User"
          fill_in "Email",        :with => "user@test.com"
          fill_in "Clave",     :with => "foobar"
          fill_in "Confirmacion", :with => "foobar"
          click_button 'Crear'
          response.should have_selector("strong", :content => "Usuario correctamente creado")
          response.should render_template('usuarios/show')

        end.should change(Usuario, :count).by(1)
      end
    end
  end
  
  describe "Ingresar y salir" do
  
  	describe "fallar" do
  	
  		it "no deberia ingresar el usuario" do
  			visit '/'
  			fill_in :email,		:with => ""
			fill_in :password,	:with => ""
			click_button
			response.should have_selector("strong", :content => "invalida")
  		end
  	end
  	
  	describe "Exito" do
  	
  		it "deberia ingresar un usuario y luego salir correctamente" do
  			usuario = Factory(:usuario)
  			visit '/'
  			fill_in :email,		:with => usuario.email
			fill_in :password,	:with => usuario.password
			click_button
			controller.should be_ingresado
			click_button "Salir"
			controller.should_not be_ingresado
  		end
  	end
  end
end
