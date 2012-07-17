Laboratorio::Application.routes.draw do

  get "escritorio/show"

  get "sessions/new"
  get "sessions/nuevo"

  resources :usuarios
  resources :turnos
  resources :clientes
  resources :sessions, :only => [:new, :create, :destroy]
  resources :zafras

  match 'dia/:fecha/zafra/nueva', :to => 'zafras#new_ajax', :as => :nueva_zafra
  match 'dia/:fecha/zafra/fin/:fecha_fin', :to => 'zafras#update_ajax', :as => :fin_zafra

  match "dias/dias", :to => 'dia#dias', :as => :lista_dias

  match '/dia/:fecha/turno/:nombre', :to => 'turno_dia#show', :as => :ver_turno_dia

  match '/dia/:fecha', :to => 'dia#show', :as => :ver_dia

  match '/analisisporturno/:fecha', :to => 'dia#analisis_turno', :as => :ver_analisis_turno

  match '/dia/turno/:id/cerrar', :to => 'turno_dia#cerrar', :as => :cerrar_turno
  match '/dia/turno/:id/anular', :to => 'turno_dia#anular', :as => :anular_turno
  match '/dia/turno/:id/abrir', :to => 'turno_dia#abrir', :as => :abrir_turno

  match '/dia/:fecha/insumoDiario/ver', :to => 'insumo_diarios#show', :as => :ver_insumo_diario
  match '/dia/:fecha/insumoDiario/nuevo', :to => 'insumo_diarios#new', :as => :crear_insumo_diario
  match '/dia/:fecha/insumoDiario/editar', :to => 'insumo_diarios#edit', :as => :editar_insumo_diario

  match '/dia/:fecha/produccionMasa/ver', :to => 'produccion_masas#show', :as => :ver_produccion_masa
  match '/dia/:fecha/produccionMasa/nuevo', :to => 'produccion_masas#new', :as => :crear_produccion_masa
  match '/dia/:fecha/produccionMasa/editar', :to => 'produccion_masas#edit', :as => :editar_produccion_masa

  match '/dia/:fecha/recepcion/ver', :to => 'recepcions#show', :as => :ver_recepcion
  match '/dia/:fecha/recepcion/nuevo', :to => 'recepcions#new', :as => :crear_recepcion
  match '/dia/:fecha/recepcion/editar', :to => 'recepcions#edit', :as => :editar_recepcion

  match '/dia/:fecha/analisis/:id', :to => 'analises#new', :as => :crear_analisis

  match '/paneldecontrol', :to => 'panel_control#show', :as => :panel_control

        match '/dia/:fecha/editar', :to =>'dia#edit', :as => :editar_dia
        match '/dia/:id/actualizar', :to => 'dia#update', :as => :actualizar_dia

  resources :dia do
    resources :turno_dia
  end

  resources :insumos, :only => [:create, :destroy, :update, :show]

  resources :insumo_diarios, :only => [:create, :destroy, :update, :show]

  resources :produccion_masas, :only => [:create, :destroy, :update, :show]

  resources :recepcions, :only => [:create, :destroy, :update, :show]

  resources :analises, :only => [:create, :destroy, :update, :show]

  resources :cliente_produccions, :only => [:new, :create, :destroy]

  match '/dia/:fecha/insumos/nuevo', :to => 'insumos#new', :as => :crear_insumo

  match '/dia/:fecha/insumos/validar', :to => 'insumos#validar', :as => :validar_insumo_turno

  match '/validar-zafras', :to => 'zafras#validar', :as => :validar_zafra

  match '/dia/:fecha/recepcion/validar', :to => 'recepcions#validar', :as => :validar_recepcion

  match '/dia/:fecha/produccionMasa/validar', :to => 'produccion_masas#validar', :as => :validar_produccion_masas

  match '/dia/:fecha/analisis/formulario/validar', :to => 'analises#validar', :as => :validar_analisis

  resources :produccions, :only => [:create, :destroy, :update, :show]

  match '/dia/:fecha/producciones/nuevo', :to => 'produccions#new', :as => :crear_produccion

  match '/dia/:fecha/producciones/validar', :to => 'produccions#validar', :as => :validar_produccion_turno

  match '/validarcliente', :to => 'cliente_produccions#validar', :as => :validar_produccion_turno

  match '/dia/:fecha/clientes', :to => 'cliente_produccions#index', :as => :cliente_produccion

  match '/dia/:fecha/clientes/:id', :to => 'cliente_produccions#destroy', :via => 'delete', :as => :cliente_produccion_destroy

  match '/actividad/:id',  :to => 'actividades#show', :as => :actividad
  match '/actividades',  :to => 'actividades#index', :as => :actividades
  match '/actividads',  :to => 'actividades#index'

  match '/ingresar',  :to => 'sessions#new'
  match '/salir',    :to => 'sessions#destroy'

  match '/crearusuario',  :to => 'usuarios#new'

  match 'crearturno',  :to => 'turnos#new'

  match 'crearcliente',  :to => 'clientes#new'

  match '/contacto',   :to => 'paginas#contacto'
  match '/ayuda',   :to => 'paginas#ayuda'
  match '/acerca',   :to => 'paginas#acerca'
  match '/escritorio',  :to => 'escritorio#show'
  match '/escritorio/:dia',  :to => 'escritorio#show', :as => 'escritorio_dia'

  match '/usuarios/:id/modificarclave',  :to => 'usuarios#edit_password', :as => :modificarclave
  match 'usuarios/:id/reiniciarclave',  :to => 'usuarios#reset_password', :as => :reiniciarclave
  root       :to => 'paginas#inicio'


  #INFORMES
  match '/informes/:fecha/produccion_por_turno', :to => 'informes#produccion_turno', :as => :informe_produccion_turno
  match '/informes/:fecha/produccion_masas_cocidas', :to => 'informes#produccion_masas_cocidas', :as => :informe_produccion_masas_cocidas
  match '/informes/:fecha/recepcion', :to => 'informes#recepcion', :as => :informe_recepcion
  match '/informes/:fecha/insumos_diarios', :to => 'informes#insumos_diarios', :as => :informe_insumos_diarios
  match '/informes/:fecha/insumos_por_turno', :to => 'informes#insumos_por_turno', :as => :informe_insumos_por_turno


  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
