class FormLinkMetadata


  extend FormMetadataUtils


  DATA = {
    link: {
      navbar: 0,
      partial: 'form',
      selectable: { :@markup_parsers => proc { MarkupParser.options_for_select } }
    },
    destroy: {
      navbar: 2,
      partial: 'form_destroy',
      selectable: {}
    }
  }


  attr_reader :current_pane, :navbar_categories, :partial_name, :selectables


  def initialize(pane: :link, arlocal_settings: nil)
    pane = pane.to_s.downcase.to_sym

    if FormLinkMetadata::DATA.has_key?(pane)
      form = FormLinkMetadata::DATA[pane]
      current_pane = pane
    else
      form = FormLinkMetadata::DATA[:link]
      current_pane = :link
    end

    @current_pane = current_pane
    @navbar_categories = FormLinkMetadata.navbar_categories
    @partial_name = form[:partial]
    @selectables = FormMetadataSelectable.new(form[:selectable])
  end


end
