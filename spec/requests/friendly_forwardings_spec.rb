require 'spec_helper'

describe "FriendlyForwardings" do
  
  it "Deberia redirigir al usuario a la pagina deseada luego de ingresar al sistema" do
  	usuario = Factory(:usuario)
  	visit '/'
  	# El test automaticamente sigue el redirect a la pagina de login
  	fill_in :email, 	:with => usuario.email
  	fill_in :password, 	:with => usuario.password
  	click_button
  	# El test sigue automaticamente el redirect nuevamente
  	# Por lo que si miro el contenido deberia ver elementos de la vista del Escritorio
  	response.should have_selector("h2", :content => 'Escritorio')
  end
  
end
