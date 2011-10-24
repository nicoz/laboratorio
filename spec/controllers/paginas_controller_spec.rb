require 'spec_helper'

describe PaginasController do

  describe "GET 'inicio'" do
    it "should be successful" do
      get 'inicio'
      response.should be_success
    end
  end

  describe "GET 'contacto'" do
    it "should be successful" do
      get 'contacto'
      response.should be_success
    end
  end

  describe "GET 'acerca'" do
    it "should be successful" do
      get 'acerca'
      response.should be_success
    end
  end

end
