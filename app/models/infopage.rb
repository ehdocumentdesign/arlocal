class Infopage < ApplicationRecord

  extend FriendlyId
  extend Neighborable

  friendly_id :slug_candidates, use: :slugged

  has_many :infopage_items, dependent: :destroy
  has_many :items, class_name: 'InfopageItem', dependent: :destroy

  has_many :infopage_articles, -> { where infopageable_type: 'Article' }, class_name: 'InfopageItem', dependent: :destroy
  has_many :infopage_links, -> { where infopageable_type: 'Link' }, class_name: 'InfopageItem', dependent: :destroy
  has_many :infopage_pictures, -> { where infopageable_type: 'Picture' }, class_name: 'InfopageItem', dependent: :destroy

  has_many :articles, through: :infopage_items, source: :infopageable, source_type: 'Article'
  has_many :links, through: :infopage_items, source: :infopageable, source_type: 'Link'
  has_many :pictures, through: :infopage_items, source: :infopageable, source_type: 'Picture'

  accepts_nested_attributes_for :infopage_items, allow_destroy: true
  accepts_nested_attributes_for :infopage_articles, allow_destroy: true
  accepts_nested_attributes_for :infopage_links, allow_destroy: true
  accepts_nested_attributes_for :infopage_pictures, allow_destroy: true
  accepts_nested_attributes_for :items, allow_destroy: true


  public


  ### created_at


  def does_have_articles
    articles.any?
  end


  def does_have_links
    links.any?
  end


  def does_have_pictures
    pictures.any?
  end


  def does_have_items
    infopage_items.any?
  end


  def does_have_items_group_bottom
    does_have_items_group_left || does_have_items_group_right
  end


  def does_have_items_group_left
    items_group_left.any?
  end


  def does_have_items_group_right
    items_group_right.any?
  end


  def does_have_items_group_top
    items_group_top.any?
  end


  ### id


  def id_admin
    friendly_id
  end


  def id_public
    friendly_id
  end


  ### info_order


  def items_all_sorted
    [ items_group_top_sorted, items_group_left_sorted, items_group_right_sorted ].flatten
  end


  def items_group_left
    infopage_items.select { |item| item.is_group_left }
  end


  def items_group_left_sorted
    items_group_left.sort { |item| item.infopage_group_order }
  end


  def items_group_right
    infopage_items.select { |item| item.is_group_right }
  end


  def items_group_right_sorted
    items_group_right.sort { |item| item.infopage_group_order }
  end


  def items_group_top
    infopage_items.select { |item| item.is_group_top }
  end


  def items_group_top_sorted
    items_group_top.sort { |item| item.infopage_group_order }
  end


  def should_generate_new_friendly_id?
    title_changed? ||
    super
  end


  ### slug


  def slug_candidates
    [
      [:title],
      [:title, :index_order ]
    ]
  end


  ### updated_at


end
