class QueryStreams
  
  
  def find_by_id(id)
    Stream.find_by_id!(id)
  end
  
  
  def find_by_slug(slug)
    Stream.find_by_slug!(slug)
  end
  
  
end