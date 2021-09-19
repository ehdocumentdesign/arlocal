class PolymorphicInfopageItem < ActiveRecord::Migration[6.1]
  def change

    create_table :infopages do |t|
      t.integer :info_order
      t.string :title
      t.timestamps
    end

    create_table :infopage_items do |t|
      t.belongs_to :infopage
      t.string :infopage_order
      t.references :infopageable, polymorphic: true
      t.timestamps
    end

  end
end
