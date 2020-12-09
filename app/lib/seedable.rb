module Seedable

  
  def seedable_attrs(keep_id: false)
    attrs = self.attributes
    attrs.delete("created_at")
    attrs.delete("updated_at")
    attrs = attrs.delete_if { |k,v| k =~ /_count/ }
    if keep_id != true
      attrs.delete("id")
    end
    
    attrs.transform_values(&:to_s).sort.to_h
  end
  
  
  def seed_statement
    "#{self.class.name}.new(#{seedable_attrs}).save"
  end

  
end