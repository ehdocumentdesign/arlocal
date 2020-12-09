class SorterIndexAdminAudio


  extend InactiveRecordSingleton
  include Rails.application.routes.url_helpers  


  DATA = [
    { 
      id: 6,
      description: 'by date released (ascending)',
      symbol: :datetime_asc
    },
    { 
      id: 7,
      description: 'by date released (descending)',
      symbol: :datetime_desc
    },
    {
      id: 0,
      description: 'by filepath (ascending)',
      symbol: :filepath_asc
    },
    {
      id: 1,
      description: 'by filepath (descending)',
      symbol: :filepath_desc
    },
    {
      id: 2,
      description: 'by isrc (ascending)',
      symbol: :isrc_asc
    },
    {
      id: 3,
      description: 'by isrc (descending)',
      symbol: :isrc_desc
    },
    {
      id: 4,
      description: 'by title (forward)',
      symbol: :title_asc
    },
    {
      id: 5,
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


  def url
    case @symbol
    when :datetime_asc
      admin_audio_index_path({filter: 'datetime_asc'})
    when :datetime_desc
      admin_audio_index_path({filter: 'datetime_desc'})
    when :filepath_asc
      admin_audio_index_path({filter: 'filepath_asc'})
    when :filepath_desc
      admin_audio_index_path({filter: 'filepath_desc'})
    when :isrc_asc
      admin_audio_index_path({filter: 'isrc_asc'})
    when :isrc_desc
      admin_audio_index_path({filter: 'isrc_desc'})
    when :title_asc
      admin_audio_index_path({filter: 'title_asc'})
    when :title_desc
      admin_audio_index_path({filter: 'title_desc'})
    else
      admin_audio_path
    end
  end
  

end
