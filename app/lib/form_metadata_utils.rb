module FormMetadataUtils


  def navbar_categories
    self::DATA.select  { |k,v| v[:navbar] != nil }.
               sort_by { |k,v| k.to_s.downcase }.
               sort_by { |k,v| v[:navbar] }.
               map     { |k,v| k }
  end


end
