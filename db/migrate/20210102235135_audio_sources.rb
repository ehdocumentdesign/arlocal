class AudioSources < ActiveRecord::Migration[6.1]
  def change
    change_table :audio do |t|
      t.rename :catalog_file_path, :source_catalog_file_path
      t.string :source_type
    end
  end
end
