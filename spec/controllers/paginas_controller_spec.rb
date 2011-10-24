require 'spec_helper'

describe PaginasController do
	render_views

  describe "GET 'inicio'" do
    it "should be successful" do
      get 'inicio'
      response.should be_success
    end
    
    it "deberia tener el titulo correcto" do
    	get 'inicio'
    	response.should have_selector("title",
    			:content => "Sistema de gestion integral de laboratorio | Inicio")
    end
  end

  describe "GET 'contacto'" do
    it "should be successful" do
      get 'contacto'
      response.should be_success
    end
    
    it "deberia tener el titulo correcto" do
    	get 'contacto'
    	response.should have_selector("title",
    			:content => "Sistema de gestion integral de laboratorio | Contacto")
    end
  end

  describe "GET 'acerca'" do
    it "should be successful" do
      get 'acerca'
      response.should be_success
    end
    
    it "deberia tener el titulo correcto" do
    	get 'acerca'
    	response.should have_selector("title",
    			:content => "Sistema de gestion integral de laboratorio | Acerca de")
    end
  end

end
