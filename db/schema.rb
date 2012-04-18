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

ActiveRecord::Schema.define(:version => 20120418210212) do

  create_table "actividads", :force => true do |t|
    t.string   "controlador"
    t.string   "accion"
    t.text     "parametros",    :limit => 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "usuario_email"
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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "updated_by"
    t.integer  "created_by"
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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "dia_id"
  end

  create_table "insumos", :force => true do |t|
    t.integer  "crudoProcesado"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "turnoDia_id"
    t.integer  "updated_by"
    t.integer  "created_by"
    t.integer  "tiraje"
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
    t.datetime "created_at"
    t.datetime "updated_at"
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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "updated_by"
    t.integer  "created_by"
  end

  create_table "turnos", :force => true do |t|
    t.string   "nombre"
    t.boolean  "habilitado"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "orden"
    t.integer  "updated_by"
    t.integer  "created_by"
  end

  create_table "usuarios", :force => true do |t|
    t.string   "nombre"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "encrypted_password"
    t.string   "salt"
    t.boolean  "admin"
    t.boolean  "habilitado",         :default => true
    t.integer  "updated_by"
    t.integer  "created_by"
  end

  add_index "usuarios", ["email"], :name => "index_usuarios_on_email", :unique => true

end
