class KeywordBuilder
  
  
  def default
    Keyword.new
  end
  
  
  def default_with(params_given)
    Keyword.new(params_given)
  end


end