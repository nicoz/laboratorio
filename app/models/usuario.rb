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
require 'digest'
class Usuario < ActiveRecord::Base
	attr_accessor :password, :cambiando
	attr_accessible :nombre, :email, :password, :password_confirmation, :admin, :cambiando
	
	email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	
	validates :nombre, :presence => {:if => Proc.new { |usuario| usuario.modo < 3 }},
			   :length => { :maximum => 50, :if => Proc.new { |usuario| usuario.modo < 3 } }
	validates :email, :presence => {:if => Proc.new { |usuario| usuario.modo < 3 } },
			  :format => { :with => email_regex, :if => Proc.new { |usuario| usuario.modo < 3  } },
			  :uniqueness => { :case_sensitive => false, :if => Proc.new { |usuario| usuario.modo < 3 } }
			  
	validates :password, :presence		=> {:if => Proc.new { |usuario| (usuario.modo == 3 or usuario.modo == 1)  }},
			     :confirmation	=> {:if => Proc.new { |usuario| (usuario.modo == 3 or usuario.modo == 1)  }},
			     :length		=> { :within => 6..40, :if => Proc.new { |usuario| (usuario.modo == 3 or 							   usuario.modo == 1) }}

	before_save :encrypt_password
	
	def modo
		return self.cambiando.to_i
	end
	
	#Retorna true si la clave del usuario es igual a la clave enviada
	def tiene_clave?(clave_enviada)
		# Comparar la encrypted_password con la version 
		# encriptada de clave_enviada
		encrypted_password == encrypt(clave_enviada)
	end
	
	def self.autenticar(email, clave_enviada)
		usuario = find_by_email(email)
		return nil if usuario.nil?
		return usuario if usuario.tiene_clave?(clave_enviada)
	end
	
	def self.authenticate(email, clave_enviada)
		usuario = find_by_email(email)
		return nil if usuario.nil?
		return usuario if usuario.tiene_clave?(clave_enviada)
	end
	
	def self.authenticate_with_salt(id, cookie_salt)
		usuario = find_by_id(id)
		(usuario && usuario.salt == cookie_salt) ? usuario : nil
	end

	private
	
		def encrypt_password
			unless password.nil?
				self.salt = make_salt unless tiene_clave?(password)
				self.encrypted_password = encrypt(password)
			end
		end
		
		def encrypt(string)
			secure_hash("#{salt}--#{string}")
		end
		
		def make_salt
			secure_hash("#{Time.now.utc}--#{password}")
		end
		
		def secure_hash(string)
			Digest::SHA2.hexdigest(string)
		end
end
