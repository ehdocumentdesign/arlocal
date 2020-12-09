module Paginateable
  
  
  def paginate(collection: self.all, limit: 20, page: 1 )
    if (page.to_s.downcase == 'all')
      paginate_all(collection: collection)
    else
      limit = limit ? limit.to_i : 20
      page = page ? page.to_i : 1
      paginate_single(collection: collection, limit: limit, page: page)
    end
  end
  
  
  def paginate_all(collection: self.all)
    Pagination.new({ 
      collection: collection
    })
  end
  
  
  def paginate_single(collection: self.all, limit: 20, page: 1)
    page_number_requested = page.to_i
    
    page_number_first = 1
    page_number_last = collection.count.fdiv(limit).ceil
    page_number_current = [[page_number_first, page_number_requested].max, page_number_last].min
    page_number_current_index = page_number_current - 1
    
    page_number_next = [page_number_last, (page_number_current + 1)].min
    page_number_previous = [page_number_first, (page_number_current - 1)].max
    
    offset_value = limit * (page_number_current_index)
    
    page_collection = collection.offset(offset_value).limit(limit)
    
    Pagination.new({
      collection: page_collection,
      nav_data: { current: page_number_current, first: page_number_first, last: page_number_last, limit: limit, next: page_number_next, prev: page_number_previous }
    })
  end
  
  
  
end