class ArlocalSettingsIconSource < ActiveRecord::Migration[6.1]
  def change
    rename_column :arlocal_settings, :html_head_favicon_catalog_filepath, :icon_source_catalog_file_path
    add_column :arlocal_settings, :icon_source_type, :string
  end
end
