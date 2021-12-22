class FormStreamMetadata


  extend FormMetadataUtils


  DATA = {
    stream: {
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


  def initialize(pane: :stream, arlocal_settings: nil)
    pane = pane.to_s.downcase.to_sym

    if FormStreamMetadata::DATA.has_key?(pane)
      form = FormStreamMetadata::DATA[pane]
      current_pane = pane
    else
      form = FormStreamMetadata::DATA[:stream]
      current_pane = :stream
    end

    @current_pane = current_pane
    @navbar_categories = FormStreamMetadata.navbar_categories
    @partial_name = form[:partial]
    @selectables = FormMetadataSelectable.new(form[:selectable])
  end


end
