# If you change this file, restart the server.

Rails.application.config.to_prepare do 

  if ArlocalSettings.table_exists?
    if QueryArlocalSettings.new.get == nil
      if ArlocalSettingsBuilder.new.build_and_save_default
        message = 'ARLOCAL: Database entry for ArlocalSettings resource not found. Creating one with default settings.'
        Rails.logger.warn message
      else
        message = 'ARLOCAL: Database entry for ArlocalSettings cannot be created. Has the database been initialized?'
        puts message
        Rails.logger.fatal message
      end
    end
  end

  if InfoPage.table_exists?
    if QueryInfoPage.new.get == nil
      if InfoPageBuilder.new.build_and_save_default
        message = 'ARLOCAL: Database entry for InfoPage resource not found. Creating one with default settings.'
        Rails.logger.warn message
      else
        message = 'ARLOCAL: Database entry for InfoPage cannot be created. Has the database been initialized?'
        Rails.logger.fatal message
      end
    end
  end

  # if Stream.table_exists?
  #   if QueryStream.new.get == nil
  #     if StreamBuilder.new.build_and_save_default
  #       message = 'ARLOCAL: Database entry for Stream resource not found. Creating one with default settings.'
  #       Rails.logger.warn message
  #     else
  #       message = 'ARLOCAL: Database entry for Stream cannot be created. Has the database been initialized?'
  #       Rails.logger.fatal message
  #     end
  #   end
  # end

end