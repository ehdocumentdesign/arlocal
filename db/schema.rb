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

ActiveRecord::Schema.define(version: 2020_12_27_061037) do

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.integer "record_id", null: false
    t.integer "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "administrators", force: :cascade do |t|
    t.datetime "current_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "email"
    t.string "encrypted_password"
    t.boolean "has_authority_to_write"
    t.datetime "last_sign_in_at"
    t.string "last_sign_in_ip"
    t.string "name"
    t.datetime "remember_created_at"
    t.datetime "reset_password_sent_at"
    t.string "reset_password_token"
    t.integer "sign_in_count"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_administrators_on_email"
    t.index ["reset_password_token"], name: "index_administrators_on_reset_password_token"
  end

  create_table "album_audio", force: :cascade do |t|
    t.integer "album_id"
    t.integer "album_order"
    t.integer "audio_id"
    t.index ["album_id"], name: "index_album_audio_on_album_id"
    t.index ["audio_id"], name: "index_album_audio_on_audio_id"
  end

  create_table "album_keywords", force: :cascade do |t|
    t.integer "album_id"
    t.integer "keyword_id"
    t.index ["album_id"], name: "index_album_keywords_on_album_id"
    t.index ["keyword_id"], name: "index_album_keywords_on_keyword_id"
  end

  create_table "album_pictures", force: :cascade do |t|
    t.integer "album_id"
    t.integer "album_order"
    t.boolean "is_coverpicture"
    t.integer "picture_id"
    t.index ["album_id"], name: "index_album_pictures_on_album_id"
    t.index ["picture_id"], name: "index_album_pictures_on_picture_id"
  end

  create_table "albums", force: :cascade do |t|
    t.string "album_artist"
    t.integer "album_pictures_sorter_id"
    t.string "artist"
    t.integer "audio_count"
    t.integer "copyright_parser_id"
    t.text "copyright_text_markup"
    t.date "date_released"
    t.integer "description_parser_id"
    t.text "description_text_markup"
    t.boolean "index_can_display_tracklist"
    t.boolean "index_tracklist_audio_includes_subtitles"
    t.boolean "indexed"
    t.integer "involved_people_parser_id"
    t.text "involved_people_text_markup"
    t.integer "keywords_count"
    t.integer "musicians_parser_id"
    t.text "musicians_text_markup"
    t.integer "pictures_count"
    t.boolean "published"
    t.boolean "show_can_cycle_pictures"
    t.boolean "show_can_have_more_pictures_link"
    t.boolean "show_can_have_vendor_widget_gumroad"
    t.string "slug"
    t.string "title"
    t.string "vendor_widget_gumroad"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["slug"], name: "index_albums_on_slug"
  end

  create_table "arlocal_settings", force: :cascade do |t|
    t.integer "admin_index_albums_sorter_id"
    t.integer "admin_index_audio_sorter_id"
    t.integer "admin_index_events_sorter_id"
    t.boolean "admin_forms_auto_keyword_enabled"
    t.integer "admin_forms_auto_keyword_id"
    t.boolean "admin_forms_edit_slug_field"
    t.boolean "admin_forms_retain_pane_for_neighbors"
    t.integer "admin_forms_selectable_pictures_sorter_id"
    t.integer "admin_index_pictures_sorter_id"
    t.integer "artist_content_copyright_year_earliest"
    t.integer "artist_content_copyright_year_latest"
    t.string "artist_name"
    t.date "audio_default_date_released"
    t.boolean "audio_default_date_released_enabled"
    t.string "audio_default_isrc_country_code"
    t.string "audio_default_isrc_registrant_code"
    t.integer "marquee_parser_id"
    t.string "marquee_text_markup"
    t.string "html_head_favicon_catalog_filepath"
    t.boolean "html_head_public_can_include_meta_description"
    t.boolean "marquee_enabled"
    t.integer "public_index_albums_sorter_id"
    t.integer "public_index_audio_sorter_id"
    t.integer "public_index_events_sorter_id"
    t.integer "public_index_pictures_sorter_id"
    t.boolean "public_nav_can_include_albums"
    t.boolean "public_nav_can_include_audio"
    t.boolean "public_nav_can_include_events"
    t.boolean "public_nav_can_include_info"
    t.boolean "public_nav_can_include_pictures"
    t.boolean "public_nav_can_include_stream"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "articles", force: :cascade do |t|
    t.string "author"
    t.integer "copyright_parser_id"
    t.text "copyright_text_markup"
    t.datetime "date_released"
    t.boolean "indexed"
    t.integer "parser_id"
    t.boolean "published"
    t.text "text_markup"
    t.string "title"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "audio", force: :cascade do |t|
    t.string "artist"
    t.string "audio_artist"
    t.integer "albums_count"
    t.string "catalog_file_path"
    t.string "composer"
    t.integer "copyright_parser_id"
    t.text "copyright_text_markup"
    t.date "date_released"
    t.integer "description_parser_id"
    t.text "description_text_markup"
    t.integer "duration_hrs"
    t.integer "duration_mins"
    t.integer "duration_secs"
    t.integer "duration_mils"
    t.integer "events_count"
    t.boolean "indexed"
    t.integer "involved_people_parser_id"
    t.text "involved_people_text_markup"
    t.string "isrc_country_code"
    t.string "isrc_registrant_code"
    t.string "isrc_year_of_reference"
    t.string "isrc_designation_code"
    t.integer "keywords_count"
    t.integer "musicians_parser_id"
    t.text "musicians_text_markup"
    t.boolean "published"
    t.string "subtitle"
    t.string "title"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["catalog_file_path"], name: "index_audio_on_catalog_file_path"
  end

  create_table "audio_keywords", force: :cascade do |t|
    t.integer "audio_id"
    t.integer "keyword_id"
    t.index ["audio_id"], name: "index_audio_keywords_on_audio_id"
    t.index ["keyword_id"], name: "index_audio_keywords_on_keyword_id"
  end

  create_table "event_audio", force: :cascade do |t|
    t.integer "event_id"
    t.integer "event_order"
    t.integer "audio_id"
    t.index ["audio_id"], name: "index_event_audio_on_audio_id"
    t.index ["event_id"], name: "index_event_audio_on_event_id"
  end

  create_table "event_keywords", force: :cascade do |t|
    t.integer "event_id"
    t.integer "keyword_id"
    t.index ["event_id"], name: "index_event_keywords_on_event_id"
    t.index ["keyword_id"], name: "index_event_keywords_on_keyword_id"
  end

  create_table "event_pictures", force: :cascade do |t|
    t.integer "event_id"
    t.integer "event_order"
    t.boolean "is_coverpicture"
    t.integer "picture_id"
    t.index ["event_id"], name: "index_event_pictures_on_event_id"
    t.index ["picture_id"], name: "index_event_pictures_on_picture_id"
  end

  create_table "events", force: :cascade do |t|
    t.string "alert"
    t.integer "audio_count"
    t.string "city"
    t.integer "datetime_year"
    t.integer "datetime_month"
    t.integer "datetime_day"
    t.integer "datetime_hour"
    t.integer "datetime_min"
    t.string "datetime_zone"
    t.datetime "datetime_utc"
    t.integer "details_parser_id"
    t.text "details_text_markup"
    t.string "event_pictures_sorter_id"
    t.boolean "indexed"
    t.integer "keywords_count"
    t.text "map_url"
    t.integer "pictures_count"
    t.boolean "published"
    t.boolean "show_can_cycle_pictures"
    t.boolean "show_can_have_more_pictures_link"
    t.string "slug"
    t.text "title_text_markup"
    t.string "venue"
    t.text "venue_url"
    t.boolean "visible_in_public_events_index"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "title_parser_id"
    t.text "title_without_markup"
    t.index ["slug"], name: "index_events_on_slug"
  end

  create_table "info_page", force: :cascade do |t|
    t.integer "article_id"
    t.integer "picture_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["article_id"], name: "index_info_page_on_article_id"
    t.index ["picture_id"], name: "index_info_page_on_picture_id"
  end

  create_table "info_page_links", force: :cascade do |t|
    t.string "display_type"
    t.boolean "info_page_can_display_details"
    t.integer "info_page_order"
    t.integer "info_page_id"
    t.integer "link_id"
    t.index ["info_page_id"], name: "index_info_page_links_on_info_page_id"
    t.index ["link_id"], name: "index_info_page_links_on_link_id"
  end

  create_table "keywords", force: :cascade do |t|
    t.integer "albums_count"
    t.integer "audio_count"
    t.boolean "can_select_albums"
    t.boolean "can_select_pictures"
    t.integer "events_count"
    t.integer "pictures_count"
    t.string "slug"
    t.string "title"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "links", force: :cascade do |t|
    t.string "address_href"
    t.string "address_inline_text"
    t.integer "details_parser_id"
    t.text "details_text_markup"
    t.string "display_method"
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "picture_keywords", force: :cascade do |t|
    t.integer "keyword_id"
    t.integer "picture_id"
    t.index ["keyword_id"], name: "index_picture_keywords_on_keyword_id"
    t.index ["picture_id"], name: "index_picture_keywords_on_picture_id"
  end

  create_table "pictures", force: :cascade do |t|
    t.integer "albums_count"
    t.string "catalog_file_path"
    t.integer "credits_parser_id"
    t.text "credits_text_markup"
    t.string "datetime_cascade_method"
    t.string "datetime_cascade_value"
    t.string "datetime_from_exif"
    t.datetime "datetime_from_file"
    t.integer "datetime_from_manual_entry_year"
    t.integer "datetime_from_manual_entry_month"
    t.integer "datetime_from_manual_entry_day"
    t.integer "datetime_from_manual_entry_hour"
    t.integer "datetime_from_manual_entry_minute"
    t.integer "datetime_from_manual_entry_second"
    t.integer "datetime_from_manual_entry_zone"
    t.integer "description_parser_id"
    t.text "description_text_markup"
    t.integer "events_count"
    t.boolean "indexed"
    t.integer "keywords_count"
    t.boolean "published"
    t.boolean "show_can_display_title"
    t.boolean "show_credit_uses_label"
    t.string "slug"
    t.integer "title_parser_id"
    t.text "title_text_markup"
    t.string "title_without_markup"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["slug"], name: "index_pictures_on_slug"
  end

  create_table "streams", force: :cascade do |t|
    t.integer "description_parser_id"
    t.text "description_text_markup"
    t.text "html_element"
    t.boolean "indexed"
    t.boolean "published"
    t.string "slug"
    t.string "title"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
end
