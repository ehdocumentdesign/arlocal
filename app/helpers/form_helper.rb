module FormHelper


  def form_message_link_inline_text
    'Text entered here is used when a page link (such as on the info page) displays as address-only. In such cases, the address itself will be used for the address inline text if this field remains blank.'
  end


  def form_message_picture_datetime_cascade
    "The 'datetime cascade' option will order pictures based on the first available data, choosing from\n1) a manually entered date/time, 2) the date/time from EXIF metadata, 3) the date/time from the picture file."
  end


  def form_message_slug_description
    'A&R.local will automatically generate a URL-friendly "slug" for albums, events, pictures, and keywords. This option, when checked, will enable a text field to edit the "slug" of a resource.'
  end


  def form_label_without_top_level(symbol)
    symbol.to_s.split('_')[1..-1].join('_').to_sym
  end


end
