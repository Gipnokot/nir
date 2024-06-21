ActiveRecord::Schema[7.1].define(version: 0) do
  enable_extension "plpgsql"

  create_table "authors", primary_key: "author_id", id: :integer, default: -> { "nextval('author_id_author_seq'::regclass)" }, force: :cascade do |t|
    t.string "lastname", limit: 50, null: false
    t.string "name", limit: 50, null: false
    t.string "fathername", limit: 50, null: false
    t.string "status", limit: 20, default: "преподаватель", null: false
    t.integer "cathedra_id", null: false
    t.check_constraint "status::text = ANY (ARRAY['студент'::character varying, 'преподаватель'::character varying]::text[])", name: "authors_status_check"
  end

  create_table "cathedras", primary_key: "cathedra_id", id: :integer, default: -> { "nextval('cathedra_id_cathedra_seq'::regclass)" }, force: :cascade do |t|
    t.string "name_cathedra", limit: 200, null: false
    t.integer "id_fac", null: false
  end

  create_table "facultys", primary_key: "id_fac", id: :integer, default: -> { "nextval('faculty_id_fac_seq1'::regclass)" }, force: :cascade do |t|
    t.string "name_fac", limit: 100, null: false
  end

  create_table "nir_authors", primary_key: ["nir_id", "author_id"], force: :cascade do |t|
    t.integer "nir_id", null: false
    t.integer "author_id", null: false
    t.integer "percent", null: false
  end

  create_table "nirs", primary_key: "nir_id", id: :integer, default: -> { "nextval('nir_id_nir_seq'::regclass)" }, force: :cascade do |t|
    t.string "title", limit: 320, null: false
    t.date "dtr", null: false
    t.text "nirtype", null: false
    t.float "volume", default: 0.0, null: false
    t.string "doi", limit: 256, null: false
    t.integer "core_rinz", limit: 2, default: 0, null: false
    t.integer "rinz", limit: 2, default: 0, null: false
    t.integer "scopus", limit: 2, default: 0, null: false
    t.integer "webofscience", limit: 2, default: 0, null: false
    t.integer "vak", limit: 2, default: 0, null: false
    t.integer "id_adviser", limit: 2, default: 0, null: false
    t.string "href", limit: 600, null: false
    t.text "output", null: false
    t.check_constraint "nirtype = ANY (ARRAY['article'::text, 'thesis'::text, 'monograph'::text, 'patent'::text, 'program'::text, 'database'::text, 'book'::text])", name: "nir_nirtype_check1"
  end

  add_foreign_key "authors", "cathedras", primary_key: "cathedra_id", name: "fk_authors_cathedras"
  add_foreign_key "cathedras", "facultys", column: "id_fac", primary_key: "id_fac", name: "fk_cathedras_facultys"
  add_foreign_key "nir_authors", "authors", primary_key: "author_id", name: "fk_nir_authors_authors"
  add_foreign_key "nir_authors", "nirs", primary_key: "nir_id", name: "fk_nir_authors_nirs"
end
