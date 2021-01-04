class NavVideo < ActiveRecord::Migration[6.1]
  def change
    change_table :arlocal_settings do |t|
      t.boolean :public_nav_can_include_videos
    end
  end
end
