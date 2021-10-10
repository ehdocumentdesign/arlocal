create_table "infopages", force: :cascade do |t|
  t.integer :order
end

create_table "infopage_items" do |t|
  t.belongs_to :infopage
  t.string :infopage_order

  t.bigint :infopageable_id
  t.string :infopagebale_type

  add_index :infopage_items, [:infopageable_id, :infopageable_id]
end


infopage
  :id
  :order
  has_many :infopage_items, as: :infopageable


infopage_items
  belongs_to :infopageable, polymorphic: true
    :infopageable_id
    :infopageable_type
      :article
      :picture
      :link
  belongs_to :info_page
    :info_page_id
  :info_page_order


has_many on :article, :picture, :link?


infopage_controller
routes
initializer
query


views
  _form_items.haml
  css
