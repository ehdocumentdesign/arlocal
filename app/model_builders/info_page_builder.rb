class InfoPageBuilder


  def build_and_save_default
    if InfoPage.first
      Rails.logger.warn 'ARLOCAL: Database entry for ArlocalSettings resource already exists.'
    else
      info_page = default
      info_page.save
      info_page
    end
  end
  
  
  def default
    InfoPage.new(params_default)
  end
  

  def params_default
    {
      id: 0
    }
  end

      
end