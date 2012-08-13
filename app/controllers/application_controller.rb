class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper
  before_filter :auditar_actividad, :except => [:controller => 'sessions', :action => 'new']
  before_filter :set_current_user_for_class_logs

  protected
    def add_breadcrumb name, url = ''
      @breadcrumbs ||= []
      url = eval(url) if url =~ /_path|url|@/
      @breadcrumbs << [name, url]
    end

    def self.add_breadcrumb name, url, options = {}
      before_filter options do |controller|
        controller.send(:add_breadcrumb, name, url)
      end
    end

    def auditar_actividad
      parametros = request.filtered_parameters.dup
      controlador = params[:controller]
      accion = params[:action]
      email = "Anonimo"
      email = usuario_actual.email unless usuario_actual.nil?
      if filtrar_actividades(controlador, accion)
        Actividad.create(
          :usuario_email => email,
          :controlador => controlador,
          :accion => accion,
          :parametros => parametros
        )
      end
    end

    def autenticar
      negar_acceso unless ingresado?
    end

  def usuario_correcto
    usuario = Usuario.find(params[:id])
    redirect_to(root_path) unless usuario_actual?(usuario) || usuario_actual.admin?
  end

    def usuario_admin
      redirect_to(root_path) unless usuario_actual.admin?
    end

    def filtrar_actividades(controlador, accion)
      if ['show', 'index', 'validar'].include?(accion) or ['paginas'].include?(controlador)
        return false
      else
        return true
      end
    end

    def set_current_user_for_class_logs
      #Este metodo carga en la clase definida en el inicializador User.rb el usuario actual
      #en la variable de Clase cu. Esto sirve para actualizar los campos
      #updated_by y created_by de forma automatica para cualquier modelo del sistema.
      ActiveRecord::Base.cu = usuario_actual.id if !usuario_actual.nil?
    end

    def validar_turno_dia
      dia = Date.parse(params[:fecha])
      if dia > Time.now.to_date
        flash[:warning] = "No se puede editar informacion de dias futuros."
        redirect_to escritorio_path
      end
      return true
    end

    def zafra_abierta
      dia = Dia.find_by_fecha(Date.parse(params[:fecha]))
      zafra = Zafra.where('dia_inicio <= ? and (dia_fin >= ? or dia_fin is null)', dia.fecha, dia.fecha).first

      redirect_to ver_dia_path(dia.fecha), :notice => "La zafra esta cerrada o aun no se creo." if zafra.nil? or !zafra.abierta
    end
end
