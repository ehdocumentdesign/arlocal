module FormHelper


  def form_message_link_inline_text
    'Text entered here is used when a page link (such as on the info page) displays as address-only. In such cases, the address itself will be used for the address inline text if this field remains blank.'
  end


  def form_label_without_top_level(symbol)
    symbol.to_s.split('_')[1..-1].join('_').to_sym
  end



end
