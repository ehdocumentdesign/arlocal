class SorterReviewAdminIsrc


  extend InactiveRecordSingleton
  include Rails.application.routes.url_helpers


  DATA = [
    {
      id: 0,
      description: 'by isrc (ascending)',
      symbol: :isrc_asc
    },
    {
      id: 1,
      description: 'by isrc (descending)',
      symbol: :isrc_desc
    },
    {
      id: 2,
      description: 'by title (ascending)',
      symbol: :title_asc
    },
    {
      id: 3,
      description: 'by title (descending)',
      symbol: :title_desc
    },
    {
      id: 4,
      description: 'by class, then title (ascending)',
      symbol: :class_title_asc
    },
    {
      id: 5,
      description: 'by class, then title (descending)',
      symbol: :class_title_desc
    }
  ]


  attr_reader :id, :description, :symbol


  def initialize(sorter)
    if sorter
      @id = sorter[:id]
      @description = sorter[:description]
      @symbol = sorter[:symbol]
    end
  end



  public


  def url
    case @symbol
    when :isrc_asc
      admin_isrc_review_path({filter: 'isrc_asc'})
    when :isrc_desc
      admin_isrc_review_path({filter: 'isrc_desc'})
    when :title_asc
      admin_isrc_review_path({filter: 'title_asc'})
    when :title_desc
      admin_isrc_review_path({filter: 'title_desc'})
    else
      public_videos_path
    end
  end


end
