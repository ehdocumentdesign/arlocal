class VideoAttributes < ActiveRecord::Migration[6.1]


  def change
    change_table :videos do |t|
      t.integer :copyright_parser_id
      t.text :copyright_text_markup
      t.date :date_released
      t.integer :description_parser_id
      t.text :description_text_markup
      t.boolean :indexed
      t.integer :involved_people_parser_id
      t.text :involved_people_text_markup
      t.boolean :published
      t.string :slug
      t.string :source_catalog_file_path
      t.integer :source_dimension_height
      t.integer :source_dimension_width
      t.string :source_type
      t.string :source_url
      t.string :title

      t.index :slug
      t.timestamps
    end

    change_table :arlocal_settings do |t|
      t.integer :admin_index_videos_sorter_id
      t.integer :public_index_videos_sorter_id
    end

    create_table :video_keywords do |t|
      t.references :keyword
      t.references :video
    end

    create_table :video_picture do |t|
      t.references :video
      t.references :picture
    end
  end


end
