class SettingsIsrcSorterAdmin < ActiveRecord::Migration[6.1]
  def change
    add_column :arlocal_settings, :admin_review_isrc_sorter_id, :integer
  end
end
