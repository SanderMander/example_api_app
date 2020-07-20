# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20_200_716_071_044) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'episodes', force: :cascade do |t|
    t.string 'title'
    t.text 'plot'
    t.integer 'number'
    t.bigint 'season_id', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['season_id'], name: 'index_episodes_on_season_id'
  end

  create_table 'movies', force: :cascade do |t|
    t.string 'title'
    t.text 'plot'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
  end

  create_table 'purchases', force: :cascade do |t|
    t.bigint 'user_id', null: false
    t.bigint 'content_id'
    t.string 'content_type'
    t.decimal 'price'
    t.integer 'quality'
    t.boolean 'expired', default: false
    t.datetime 'available_until'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index %w[user_id content_type content_id], name: 'index_purchases_on_user_id_and_content_type_and_content_id', unique: true
    t.index %w[user_id expired], name: 'index_purchases_on_user_id_and_expired'
    t.index ['user_id'], name: 'index_purchases_on_user_id'
  end

  create_table 'seasons', force: :cascade do |t|
    t.string 'title'
    t.text 'plot'
    t.integer 'number'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
  end

  create_table 'users', force: :cascade do |t|
    t.string 'email'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
  end

  add_foreign_key 'episodes', 'seasons'
  add_foreign_key 'purchases', 'users'
end
