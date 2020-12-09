class AutoKeywordMetadata

  
  attr_reader :enabled, :keyword_id, :keyword_title

  
  def initialize(arlocal_settings)
    @enabled = arlocal_settings.admin_forms_auto_keyword_enabled
    if @enabled
      @keyword = Keyword.find(arlocal_settings.admin_forms_auto_keyword_id)
    end
  end
  
  
  public
  
  
  def keyword_id
    if @enabled
      @keyword.id
    end
  end
  
  
  def keyword_title
    if @enabled
      @keyword.title
    end
  end
  
  
end