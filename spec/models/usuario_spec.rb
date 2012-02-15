# == Schema Information
#
# Table name: usuarios
#
#  id         :integer         not null, primary key
#  nombre     :string(255)
#  email      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe Usuario do

	before(:each) do
		@attr = { 
			:nombre => "Usuario Ejemplo",
			:email => "usuario@example.com",
			:password => "foobar",
			:password_confirmation => "foobar",
			:cambiando => 1 }
	end
	
	describe "validaciones de clave" do
		it "deberia requerir una clave" do
			Usuario.new(@attr.merge(:password => "", :password_confirmation => "", :cambiando => 3)).
				should_not be_valid
		end
	
		it "deberia requerir que las claves fueran iguales" do
			Usuario.new(@attr.merge(:password_confirmation => "invalid", :cambiando => 3)).
				should_not be_valid
		end
	
		it "deberia rechazar claves cortas" do
			corta = "a" * 5
			hash = @attr.merge(:password => corta, :password_confirmation => corta, :cambiando => 3)
			Usuario.new(hash).should_not be_valid
		end
		
		it "deberia rechazar claves largas" do
			larga = "a" * 41
			hash = @attr.merge(:password => larga, :password_confirmation => larga, :cambiando => 3)
			Usuario.new(hash).should_not be_valid
		end
	end
	
	describe "encriptacion de clave" do
	
		before(:each) do
			@usuario = Usuario.create!(@attr)
		end
		
		it "deberia tener un atributo para la clave encriptada" do
			@usuario.should respond_to(:encrypted_password)
		end
		
		it "deberia cargar la clave encriptada" do
			@usuario.encrypted_password.should_not be_blank
		end
		
		describe "metodo tiene_clave?" do
			
			it "deberia ser verdadero si las claves son iguales" do
				@usuario.tiene_clave?(@attr[:password]).should be_true
			end
			
			it "deberia ser falso si las claves no son iguales" do
				@usuario.tiene_clave?("invalida").should be_false
			end
		end
		
		describe "metodo autenticar" do
		
			it "debeira retornar nil cuando sea incorrecto el mail o la clave" do
				usuario_con_clave_incorrecta = Usuario.autenticar(@attr[:email], "maldato")
				usuario_con_clave_incorrecta.should be_nil
			end
			
			it "deberia retornar nil para una direccion de correo que no tenga usuario" do
				usuario_inexistente = Usuario.autenticar("bar@foo.com", @attr[:password])
				usuario_inexistente.should be_nil
			end
			
			it "deberia retornar el usuario correcto cuando sean correctos el email y la clave" do
				usuario_correcto = Usuario.autenticar(@attr[:email], @attr[:password])
				usuario_correcto == @usuario
			end
		end
	end
	it "deberia crear un nuevo usuario para atributos correctos" do
		Usuario.create!(@attr)
	end
	
	it "deberia requerir el nombre del usuario" do
		usuario_sin_nombre = Usuario.new(@attr.merge(:nombre => ""))
		usuario_sin_nombre.should_not be_valid
	end
	
	it "deberia requerir el email" do
		usuario_sin_email = Usuario.new(@attr.merge(:email => ""))
		usuario_sin_email.should_not be_valid
	end
	
	it "deberia rechazar nombre que sean demasiado largos" do
		nombre_largo = "a" * 51
		usuario_nombre_largo = Usuario.new(@attr.merge(:nombre => nombre_largo))
		usuario_nombre_largo.should_not be_valid
	end
	
	it "deberia aceptar emails validos" do
		direcciones = %w[usuario@foo.com EL_USUARIO@foo.bar.org primero.ultimo@foo.jp]
		direcciones.each do |direccion|
			usuario_mail_correcto = Usuario.new(@attr.merge(:email => direccion))
			usuario_mail_correcto.should be_valid
		end
	end
	
	it "deberia rechazar emails invalidos" do
		direcciones = %w[usuario@fuu,com usuario_en_foo.org ejemplo.usuario@foo.]
		direcciones.each do |direccion|
			usuario_mail_invalido = Usuario.new(@attr.merge(:email => direccion))
			usuario_mail_invalido.should_not be_valid
		end
	end
	
	it "deberia rechazar emails duplicados" do
		Usuario.create!(@attr) #crea y guarda el usuario todo en un paso
		usuario_con_email_duplicado = Usuario.new(@attr)
		usuario_con_email_duplicado.should_not be_valid
	end
	
	it "deberia rechazar emails duplicados ignorando las mayusculas" do
		usuario_email_mayusculas = @attr[:email].upcase
		Usuario.create!(@attr.merge(:email => usuario_email_mayusculas))
		usuario_con_email_duplicado = Usuario.new(@attr)
		usuario_con_email_duplicado.should_not be_valid
	end
	
	describe "atributo de administrador" do
	
		before(:each) do
			@usuario = Usuario.create!(@attr)
		end
		
		it "deberia responder a admin" do
			@usuario.should respond_to(:admin)
		end
		
		it "deberia no ser admin por defecto" do
			@usuario.should_not be_admin
		end
		
		it "deberia ser convertible en admin" do
			@usuario.toggle!(:admin)
			@usuario.should be_admin
		end
	end
end
