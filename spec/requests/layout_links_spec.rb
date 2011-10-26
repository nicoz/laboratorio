require 'spec_helper'

describe "LayoutLinks" do
  
	it "Deberia tener una pagina de Inicio en '/'" do
		get '/'
		response.should have_selector('title', :content => "Inicio")
	end
	
	it "Deberia tener una pagina Acerca en '/acerca'" do
		get '/acerca'
		response.should have_selector('title', :content => "Acerca de")
	end
	
	it "Deberia tener una pagina Ayuda en '/ayuda'" do
		get '/ayuda'
		response.should have_selector('title', :content => "Ayuda")
	end
end
