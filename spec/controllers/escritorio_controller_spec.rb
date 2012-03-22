require 'spec_helper'

describe EscritorioController do

	describe "Get 'show'" do
		describe "Sin usuario logeado" do
			it "Deberia redirigir al inicio" do
				get 'show' 
				response.should be_redirect
			end
		end
		
			describe 'Para usuarios no admin' do
				before(:each) do
					@usuario = test_ingresar(Factory(:usuario))
				end
				
				it "Deberia mostrar el escritorio de usuarios comunes" do
					get 'show'
					response.should be_success
					response.should render_template("show")
				end
			end
			
			describe 'Para usaurios admin' do
				before(:each) do
					@usuario = test_ingresar(Factory(:usuario, :admin => true))
				end
				
				it "Deberia mostrar el escritorio de usuarios comunes" do
					get 'show'
					response.should be_success
					response.should render_template("show")
				end
			end
	end
end
