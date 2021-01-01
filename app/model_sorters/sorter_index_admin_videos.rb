class SorterIndexAdminVideos


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
      admin_videos_path({filter: 'datetime_asc'})
    when :datetime_desc
      admin_videos_path({filter: 'datetime_desc'})
    when :title_asc
      admin_videos_path({filter: 'title_asc'})
    when :title_desc
      admin_videos_path({filter: 'title_desc'})
    else
      admin_videos_path
    end
  end


end
