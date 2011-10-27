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
		@attr = { :nombre => "Usuario Ejemplo", :email => "usuario@example.com" }
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
end
