class VideoPicturesPlural < ActiveRecord::Migration[6.1]
  def change
    rename_table :video_picture, :video_pictures
  end
end
