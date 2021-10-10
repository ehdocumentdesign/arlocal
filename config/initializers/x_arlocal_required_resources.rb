# If you change this file, restart the server.
Rails.application.config.to_prepare do
  if ArlocalSettings.table_exists?
    if QueryArlocalSettings.get == nil
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
end
