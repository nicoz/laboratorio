# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120614192748) do

  create_table "actividads", :force => true do |t|
    t.string   "controlador"
    t.string   "accion"
    t.text     "parametros",    :limit => 255
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
    t.string   "usuario_email"
  end

  create_table "analises", :force => true do |t|
    t.decimal  "azucar_crudo_brix",        :precision => 10, :scale => 2
    t.decimal  "azucar_crudo_pol",         :precision => 10, :scale => 2
    t.decimal  "azucar_crudo_pza",         :precision => 10, :scale => 2
    t.decimal  "azucar_crudo_ph",          :precision => 10, :scale => 1
    t.integer  "azucar_crudo_color"
    t.decimal  "azucar_crudo_ceniza",      :precision => 10, :scale => 3
    t.decimal  "azucar_crudo_invert",      :precision => 10, :scale => 3
    t.decimal  "azucar_crudo_humedad",     :precision => 10, :scale => 3
    t.decimal  "miel_de_afinacion_brix",   :precision => 10, :scale => 2
    t.decimal  "miel_de_afinacion_pol",    :precision => 10, :scale => 2
    t.decimal  "miel_de_afinacion_pza",    :precision => 10, :scale => 2
    t.decimal  "miel_de_afinacion_ph",     :precision => 10, :scale => 1
    t.decimal  "miel_de_afinacion_ceniza", :precision => 10, :scale => 3
    t.decimal  "miel_de_afinacion_invert", :precision => 10, :scale => 3
    t.decimal  "azucar_afinada_brix",      :precision => 10, :scale => 2
    t.decimal  "azucar_afinada_pol",       :precision => 10, :scale => 2
    t.decimal  "azucar_afinada_pza",       :precision => 10, :scale => 2
    t.decimal  "azucar_afinada_ph",        :precision => 10, :scale => 1
    t.integer  "azucar_afinada_color"
    t.decimal  "azucar_afinada_ceniza",    :precision => 10, :scale => 3
    t.decimal  "azucar_afinada_invert",    :precision => 10, :scale => 3
    t.decimal  "azucar_afinada_humedad",   :precision => 10, :scale => 3
    t.decimal  "refundicion_brix",         :precision => 10, :scale => 2
    t.decimal  "refundicion_pol",          :precision => 10, :scale => 2
    t.decimal  "refundicion_pza",          :precision => 10, :scale => 2
    t.decimal  "refundicion_ph",           :precision => 10, :scale => 1
    t.integer  "refundicion_color"
    t.decimal  "encalado_be",              :precision => 10, :scale => 2
    t.decimal  "encalado_ph",              :precision => 10, :scale => 1
    t.decimal  "encalado_alcal",           :precision => 10, :scale => 1
    t.decimal  "jugo_carbonatado_ph",      :precision => 10, :scale => 1
    t.decimal  "primera_filtracion_brix",  :precision => 10, :scale => 2
    t.decimal  "primera_filtracion_pol",   :precision => 10, :scale => 2
    t.decimal  "primera_filtracion_pza",   :precision => 10, :scale => 2
    t.decimal  "primera_filtracion_ph",    :precision => 10, :scale => 1
    t.integer  "primera_filtracion_color"
    t.decimal  "jarabe_brix",              :precision => 10, :scale => 2
    t.decimal  "jarabe_pol",               :precision => 10, :scale => 2
    t.decimal  "jarabe_pza",               :precision => 10, :scale => 2
    t.decimal  "jarabe_ph",                :precision => 10, :scale => 1
    t.integer  "jarabe_color"
    t.decimal  "masa_cocida_a_brix",       :precision => 10, :scale => 2
    t.decimal  "masa_cocida_a_pol",        :precision => 10, :scale => 2
    t.decimal  "masa_cocida_a_pza",        :precision => 10, :scale => 2
    t.decimal  "masa_cocida_a_ph",         :precision => 10, :scale => 1
    t.decimal  "masa_cocida_b_brix",       :precision => 10, :scale => 2
    t.decimal  "masa_cocida_b_pol",        :precision => 10, :scale => 2
    t.decimal  "masa_cocida_b_pza",        :precision => 10, :scale => 2
    t.decimal  "masa_cocida_b_ph",         :precision => 10, :scale => 1
    t.decimal  "masa_cocida_c_brix",       :precision => 10, :scale => 2
    t.decimal  "masa_cocida_c_pol",        :precision => 10, :scale => 2
    t.decimal  "masa_cocida_c_pza",        :precision => 10, :scale => 2
    t.decimal  "masa_cocida_c_ph",         :precision => 10, :scale => 1
    t.decimal  "masa_cocida_d_brix",       :precision => 10, :scale => 2
    t.decimal  "masa_cocida_d_pol",        :precision => 10, :scale => 2
    t.decimal  "masa_cocida_d_pza",        :precision => 10, :scale => 2
    t.decimal  "masa_cocida_d_ph",         :precision => 10, :scale => 1
    t.decimal  "masa_cocida_e_brix",       :precision => 10, :scale => 2
    t.decimal  "masa_cocida_e_pol",        :precision => 10, :scale => 2
    t.decimal  "masa_cocida_e_pza",        :precision => 10, :scale => 2
    t.decimal  "masa_cocida_e_ph",         :precision => 10, :scale => 1
    t.decimal  "masa_afinada_1_brix",      :precision => 10, :scale => 2
    t.decimal  "masa_afinada_1_pol",       :precision => 10, :scale => 2
    t.decimal  "masa_afinada_1_pza",       :precision => 10, :scale => 2
    t.decimal  "masa_afinada_1_ph",        :precision => 10, :scale => 1
    t.decimal  "masa_afinada_2_brix",      :precision => 10, :scale => 2
    t.decimal  "masa_afinada_2_pol",       :precision => 10, :scale => 2
    t.decimal  "masa_afinada_2_pza",       :precision => 10, :scale => 2
    t.decimal  "masa_afinada_2_ph",        :precision => 10, :scale => 1
    t.decimal  "miel_a_brix",              :precision => 10, :scale => 2
    t.decimal  "miel_a_pol",               :precision => 10, :scale => 2
    t.decimal  "miel_a_pza",               :precision => 10, :scale => 2
    t.decimal  "miel_a_ph",                :precision => 10, :scale => 1
    t.integer  "miel_a_color"
    t.decimal  "miel_b_brix",              :precision => 10, :scale => 2
    t.decimal  "miel_b_pol",               :precision => 10, :scale => 2
    t.decimal  "miel_b_pza",               :precision => 10, :scale => 2
    t.decimal  "miel_b_ph",                :precision => 10, :scale => 1
    t.decimal  "miel_c_brix",              :precision => 10, :scale => 2
    t.decimal  "miel_c_pol",               :precision => 10, :scale => 2
    t.decimal  "miel_c_pza",               :precision => 10, :scale => 2
    t.decimal  "miel_c_ph",                :precision => 10, :scale => 1
    t.decimal  "miel_d_brix",              :precision => 10, :scale => 2
    t.decimal  "miel_d_pol",               :precision => 10, :scale => 2
    t.decimal  "miel_d_pza",               :precision => 10, :scale => 2
    t.decimal  "miel_d_ph",                :precision => 10, :scale => 1
    t.decimal  "miel_e_brix",              :precision => 10, :scale => 2
    t.decimal  "miel_e_pol",               :precision => 10, :scale => 2
    t.decimal  "miel_e_pza",               :precision => 10, :scale => 2
    t.decimal  "miel_e_ph",                :precision => 10, :scale => 1
    t.decimal  "miel_afinada_1_brix",      :precision => 10, :scale => 2
    t.decimal  "miel_afinada_1_pol",       :precision => 10, :scale => 2
    t.decimal  "miel_afinada_1_pza",       :precision => 10, :scale => 2
    t.decimal  "miel_afinada_1_ph",        :precision => 10, :scale => 1
    t.decimal  "miel_afinada_2_brix",      :precision => 10, :scale => 2
    t.decimal  "miel_afinada_2_pol",       :precision => 10, :scale => 2
    t.decimal  "miel_afinada_2_pza",       :precision => 10, :scale => 2
    t.decimal  "miel_afinada_2_ph",        :precision => 10, :scale => 1
    t.decimal  "agua_madre_brix",          :precision => 10, :scale => 2
    t.decimal  "agua_madre_pol",           :precision => 10, :scale => 2
    t.decimal  "agua_madre_pza",           :precision => 10, :scale => 2
    t.decimal  "agua_madre_ph",            :precision => 10, :scale => 1
    t.decimal  "melaza_brix",              :precision => 10, :scale => 2
    t.decimal  "melaza_pol",               :precision => 10, :scale => 2
    t.decimal  "melaza_pza",               :precision => 10, :scale => 2
    t.decimal  "melaza_ph",                :precision => 10, :scale => 1
    t.decimal  "melaza_ceniza",            :precision => 10, :scale => 3
    t.decimal  "melaza_invert",            :precision => 10, :scale => 3
    t.integer  "azucar_a_color"
    t.decimal  "azucar_a_humedad",         :precision => 10, :scale => 3
    t.integer  "azucar_b_color"
    t.decimal  "azucar_b_humedad",         :precision => 10, :scale => 3
    t.integer  "azucar_c_color"
    t.decimal  "azucar_c_humedad",         :precision => 10, :scale => 3
    t.integer  "azucar_d_color"
    t.decimal  "azucar_d_humedad",         :precision => 10, :scale => 3
    t.datetime "created_at",                                              :null => false
    t.datetime "updated_at",                                              :null => false
    t.integer  "turnoDia_id"
  end

  create_table "cliente_produccions", :force => true do |t|
    t.integer  "produccion_id"
    t.integer  "cliente_id"
    t.integer  "azucar_big_bag"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "clientes", :force => true do |t|
    t.string   "nombre"
    t.boolean  "habilitado", :default => true
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
    t.integer  "orden"
  end

  create_table "dia", :force => true do |t|
    t.date     "fecha"
    t.boolean  "activo"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.integer  "updated_by"
    t.integer  "created_by"
    t.string   "observaciones"
  end

  create_table "insumo_diarios", :force => true do |t|
    t.integer  "aserrin"
    t.integer  "chip"
    t.integer  "gasoil"
    t.integer  "lenia_caldera"
    t.integer  "carbon_activado"
    t.decimal  "auxiliar_filtracion"
    t.integer  "acido_clorhidrico"
    t.integer  "cal_viva"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.integer  "dia_id"
  end

  create_table "insumos", :force => true do |t|
    t.integer  "crudoProcesado"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.integer  "turnoDia_id"
    t.integer  "updated_by"
    t.integer  "created_by"
    t.integer  "tiraje"
  end

  create_table "produccion_masas", :force => true do |t|
    t.integer  "numero_masas_a"
    t.integer  "numero_masas_b"
    t.integer  "numero_masas_c"
    t.integer  "numero_masas_d"
    t.integer  "dia_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "produccions", :force => true do |t|
    t.decimal  "paquetesPapel"
    t.decimal  "paquetesPolietileno"
    t.decimal  "melaza"
    t.decimal  "rubio"
    t.decimal  "industriaBolsas"
    t.decimal  "bolsasAzucarlito"
    t.decimal  "bigBagAzucarlito"
    t.decimal  "bigBagDnd"
    t.decimal  "bigBagClientes"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.integer  "turnoDia_id"
  end

  create_table "recepcions", :force => true do |t|
    t.integer  "azucar_crudo"
    t.decimal  "polarizacion"
    t.decimal  "perdida_en_azucar"
    t.decimal  "azucar_en_melaza"
    t.integer  "dia_id"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  create_table "turno_dia", :force => true do |t|
    t.integer  "dia_id"
    t.integer  "turno_id"
    t.string   "estado"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "updated_by"
    t.integer  "created_by"
  end

  create_table "turnos", :force => true do |t|
    t.string   "nombre"
    t.boolean  "habilitado"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "orden"
    t.integer  "updated_by"
    t.integer  "created_by"
  end

  create_table "usuarios", :force => true do |t|
    t.string   "nombre"
    t.string   "email"
    t.datetime "created_at",                           :null => false
    t.datetime "updated_at",                           :null => false
    t.string   "encrypted_password"
    t.string   "salt"
    t.boolean  "admin"
    t.boolean  "habilitado",         :default => true
    t.integer  "updated_by"
    t.integer  "created_by"
  end

  add_index "usuarios", ["email"], :name => "index_usuarios_on_email", :unique => true

  create_table "zafras", :force => true do |t|
    t.date     "dia_inicio"
    t.date     "dia_fin"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
