class PolymorphicInfopageItem < ActiveRecord::Migration[6.1]
  def change

    create_table :infopages do |t|
      t.integer :index_order
      t.string :slug
      t.string :title
      t.timestamps
      t.index ["slug"], name: "index_infopages_on_slug"

    end

    create_table :infopage_items do |t|
      t.belongs_to :infopage
      t.string :infopage_group
      t.integer :infopage_group_order
      t.references :infopageable, polymorphic: true
      t.timestamps
    end

  end
end
