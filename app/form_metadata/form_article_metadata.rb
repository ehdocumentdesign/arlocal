class FormArticleMetadata


  extend FormMetadataUtils


  DATA = {
    article: {
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


  def initialize(pane: :article)
    pane = pane.to_s.downcase.to_sym

    if FormArticleMetadata::DATA.has_key?(pane)
      form = FormArticleMetadata::DATA[pane]
      current_pane = pane
    else
      form = FormArticleMetadata::DATA[:article]
      current_pane = :article
    end

    @current_pane = current_pane
    @navbar_categories = FormArticleMetadata.navbar_categories
    @partial_name = form[:partial]
    @selectables = FormMetadataSelectable.new(form[:selectable])
  end


end
