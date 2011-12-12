require 'spec_helper'

describe PaginasController do
	render_views

  before(:each) do
    @titulo = "Sistema de gestion integral de laboratorio | "
  end
  
  describe "GET 'inicio'" do
    it "should be successful" do
      get 'inicio'
      response.should be_redirect
    end
    
    it "si el usuario no esta logeado deberia redirigir al ingreso" do
	get 'inicio'
	response.should redirect_to(ingresar_path)
    end
    
    describe "si el usuario ya ingreso al sistema" do
    
    	before(:each) do
    		@usuario = Factory(:usuario)
    		test_ingresar(@usuario)
    	end
    
    	it "deberia redirigir al escritorio de trabajo" do
    		get 'inicio'
    		response.should redirect_to(escritorio_path(@usuario))
    	end

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
    			:content => @titulo + "Contacto")
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
    			:content => @titulo + "Acerca de")
    end
  end
  
  describe "GET 'ayuda'" do
  	it "deberia ser exitoso" do
  		get 'ayuda'
  		response.should be_success
  	end
  	
  	it "deberia tener el titulo correcto" do
  		get 'ayuda'
  		response.should have_selector("title",
  				:content => @titulo + "Ayuda")
  	end
  end

end
