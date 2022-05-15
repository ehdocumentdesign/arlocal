class SorterIndexPublicVideos


  extend InactiveRecordSingleton
  include Rails.application.routes.url_helpers


  DATA = [
    {
      id: 0,
      description: 'by release date (old - new)',
      symbol: :datetime_asc
    },
    {
      id: 1,
      description: 'by release date (new - old)',
      symbol: :datetime_desc
    },
    {
      id: 2,
      description: 'by title (forward)',
      symbol: :title_asc
    },
    {
      id: 3,
      description: 'by title (reverse)',
      symbol: :title_desc
    },
    {
      id: 4,
      description: 'by keyword, then title (forward)',
      symbol: :keyword_title_asc
    },
    {
      id: 5,
      description: 'by keyword, then datetime (new - old)',
      symbol: :keyword_datetime_desc
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
    when :datetime_asc
      public_videos_path({filter: 'datetime_asc'})
    when :datetime_desc
      public_videos_path({filter: 'datetime_desc'})
    when :keyword_datetime_desc
      public_videos_path({filter: 'keyword_datetime_desc'})
    when :keyword_title_asc
      public_videos_path({filter: 'keyword_title_asc'})
    when :title_asc
      public_videos_path({filter: 'title_asc'})
    when :title_desc
      public_videos_path({filter: 'title_desc'})
    else
      public_videos_path
    end
  end


end
