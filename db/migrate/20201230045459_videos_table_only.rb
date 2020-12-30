class VideosTableOnly < ActiveRecord::Migration[6.1]
  def change
    create_table :videos
  end
end
