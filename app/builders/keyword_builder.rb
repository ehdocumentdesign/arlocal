class KeywordBuilder


  protected
  

  def self.default
    Keyword.new
  end


  def self.default_with(params_given)
    Keyword.new(params_given)
  end


end
