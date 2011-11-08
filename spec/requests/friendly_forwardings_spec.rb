require 'spec_helper'

describe "FriendlyForwardings" do
  
  it "Deberia redirigir al usuario a la pagina deseada luego de ingresar al sistema" do
  	usuario = Factory(:usuario)
  	visit edit_usuario_path(usuario)
  	# El test automaticamente sigue el redirect a la pagina de login
  	fill_in :email, 	:with => usuario.email
  	fill_in :password, 	:with => usuario.password
  	click_button
  	# El test sigue automaticamente el redirect nuevamente
  	response.should render_template('usuarios/edit')
  end
  
end
