class Pagination


  attr_reader :collection, :nav_data
  

  def initialize(params)
    @collection = params[:collection]
    @nav_data = params[:nav_data]
  end


  public
  
  
  def base
    @nav_data[:base]
  end
  
  
  def current_page_number
    @nav_data[:current]
  end
  
  
  def first_page_number
    @nav_data[:first]
  end
  
  
  def last_page_number
    @nav_data[:last]
  end
  
  
  def next_page_number
    @nav_data[:next]
  end
  
  
  def prev_page_number
    @nav_data[:prev]
  end
  

end
