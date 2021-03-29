module ApplicationHelper


  def app_about_arlocal_link(administrator: false)
    if (administrator == true) && (controller_path.split('/')[0] == 'admin')
      link_to('A&amp;R.local'.html_safe, admin_about_arlocal_path, target: '_blank')
    else
      'A&amp;R.local'
    end
  end


  def app_logo(html_class: nil)
    tag :img, src: asset_url("#{Rails.application.config.x.arlocal[:app_logo_file_path]}", skip_pipeline: true), class: html_class
  end


  def artist_copyright_summary(arlocal_settings)
    "© #{artist_copyright_year_range(arlocal_settings)} except where indicated"
  end


  def artist_copyright_year_range(arlocal_settings)
    current_year = Time.zone.now.year.to_s
    given_year = @arlocal_settings.artist_content_copyright_year_earliest.to_s

    if given_year == ''
      "#{current_year}"
    elsif given_year == current_year
      "#{given_year}"
    elsif given_year.to_i < current_year.to_i
      "#{given_year}–#{current_year}"
    else
      "#{current_year}"
    end
  end


end
