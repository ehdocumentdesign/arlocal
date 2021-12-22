class FormInfopageMetadata


  extend FormMetadataUtils


  DATA = {
    infopage: {
      navbar: 0,
      partial: 'form',
      selectable: {
        :@item_groups => proc { InfopageItem.group_options_for_select }
      }
    },
    article_join_single: {
      navbar: nil,
      partial: 'form_article_join_single',
      selectable: {
        :@articles => proc { Article.all },
        :@item_groups => proc { InfopageItem.group_options_for_select }
      }
    },
    articles: {
      navbar: 1,
      partial: 'form_articles',
      selectable: {
        :@item_groups => proc { InfopageItem.group_options_for_select }
      }
    },
    link_join_single: {
      navbar: nil,
      partial: 'form_link_join_single',
      selectable: {
        :@item_groups => proc { InfopageItem.group_options_for_select },
        :@links => proc { QueryLinks.options_for_select_admin }

      }
    },
    links: {
      navbar: 1,
      partial: 'form_links',
      selectable: {
        :@item_groups => proc { InfopageItem.group_options_for_select }

      }
    },
    picture_import: {
      navbar: nil,
      partial: 'form_picture_import',
      selectable: {
        :@item_groups => proc { InfopageItem.group_options_for_select }

      }
    },
    picture_join_by_keyword: {
      navbar: nil,
      partial: 'form_picture_join_by_keyword',
      selectable: {
        :@item_groups => proc { InfopageItem.group_options_for_select },
        :@keywords => proc { QueryKeywords.options_for_select_admin }
      }
    },
    picture_join_single: {
      navbar: nil,
      partial: 'form_picture_join_single',
      selectable: {
        :@item_groups => proc { InfopageItem.group_options_for_select },
        :@pictures => lambda { |arlocal_settings| QueryPictures.options_for_select_admin_with_nil(arlocal_settings) }

      }
    },
    picture_upload: {
      navbar: nil,
      partial: 'form_picture_upload',
      selectable: {
        :@item_groups => proc { InfopageItem.group_options_for_select }
      }
    },
    pictures: {
      navbar: 1,
      partial: 'form_pictures',
      selectable: {
        :@item_groups => proc { InfopageItem.group_options_for_select }
      }
    },
    destroy: {
      navbar: 2,
      partial: 'form_destroy',
      selectable: {}
    }
  }


  attr_reader :current_pane, :navbar_categories, :partial_name, :selectables


  def initialize(pane: :infopage, arlocal_settings: QueryArlocalSettings.get)
    pane = pane.to_s.downcase.to_sym

    if FormInfopageMetadata::DATA.has_key?(pane)
      form = FormInfopageMetadata::DATA[pane]
      current_pane = pane
    else
      form = FormInfopageMetadata::DATA[:infopage]
      current_pane = :infopage
    end

    @current_pane = current_pane
    @navbar_categories = FormInfopageMetadata.navbar_categories
    @partial_name = form[:partial]
    @selectables = FormMetadataSelectable.new(form[:selectable], arlocal_settings)
  end


end
