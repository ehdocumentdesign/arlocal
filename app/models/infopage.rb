class Infopage < ApplicationRecord


  has_many :infopage_items, dependent: :destroy

  accepts_nested_attributes_for :infopage_items, allow_destroy: true


  public


  ### created_at


  def has_items_group_a
    items_group_a.any?
  end


  def has_items_group_a_or_b
    has_items_group_a || has_items_group_b
  end


  def has_items_group_b
    items_group_b.any?
  end


  def has_items_group_nil
    items_group_nil.any?
  end


  ### id


  def items_group_a
    infopage_items.select { |item| item.is_group?('a') }
  end


  def items_group_a_sorted
    items_group_a.sort { |item| item.order_within_group }
  end


  def items_group_b
    infopage_items.select { |item| item.is_group?('b') }
  end


  def items_group_b_sorted
    items_group_b.sort { |item| item.order_within_group }
  end


  def items_group_nil
    infopage_items.select { |item| item.is_group?(nil) }
  end


  def items_group_nil_sorted
    items_group_nil.sort { |item| item.order_within_group }
  end



  ### updated_at


end
