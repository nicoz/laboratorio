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

ActiveRecord::Schema.define(:version => 20120214192252) do

  create_table "actividads", :force => true do |t|
    t.string   "controlador"
    t.string   "accion"
    t.text     "parametros",    :limit => 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "usuario_email"
  end

  create_table "dia", :force => true do |t|
    t.date     "fecha"
    t.boolean  "activo"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "insumos", :force => true do |t|
    t.integer  "crudoProcesado"
    t.integer  "leniaCaldera"
    t.integer  "carbonActivado"
    t.integer  "auxiliarDeFiltracion"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "piedra_de_cal"
    t.integer  "turnoDia_id"
    t.integer  "chip"
    t.integer  "aserrin"
  end

  create_table "turno_dia", :force => true do |t|
    t.integer  "dia_id"
    t.integer  "turno_id"
    t.string   "estado"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "turnos", :force => true do |t|
    t.string   "nombre"
    t.boolean  "habilitado"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "orden"
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
  end

  add_index "usuarios", ["email"], :name => "index_usuarios_on_email", :unique => true

end
