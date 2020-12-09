module Neighborable
  
  
  def neighborhood(resource, collection: self.all, distance: 1)
    Neighborhood.new(neighbors(resource, collection: collection, distance: distance))
  end
  
  
  def neighbors(resource, collection: self.all, distance: 1)
    { 
      following: neighbors_following(resource, collection: collection, distance: distance),
      preceeding: neighbors_preceeding(resource, collection: collection, distance: distance)
    }
  end
    
    
  def neighbors_following(resource, collection: self.all, distance: 1)
    if collection.include?(resource)
      result = []
      resource_index = collection.find_index(resource)
      (1..(distance.to_i)).each do |dx|
        neighbor_index = (resource_index + dx) % collection.count
        result << collection[neighbor_index]
      end
      result
    end
  end


  def neighbors_preceeding(resource, collection: self.all, distance: 1)
    if collection.include?(resource)
      result = []
      resource_index = collection.find_index(resource)
      (1..(distance.to_i)).each do |dx|
        neighbor_index = (resource_index - dx) % collection.count
        result << collection[neighbor_index]
      end
      result
    end
  end
  
    
end