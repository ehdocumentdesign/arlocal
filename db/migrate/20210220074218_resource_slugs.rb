class ResourceSlugs < ActiveRecord::Migration[6.1]
  def change
    add_column :articles, :slug, :string
    add_index :articles, :slug
    add_column :audio, :slug, :string
    add_index :audio, :slug
    add_index :keywords, :slug
  end
end
