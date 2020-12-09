class SorterIndexPublicAudio


  extend InactiveRecordSingleton
  include Rails.application.routes.url_helpers  


  DATA = [
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
    when :filepath_asc
      public_audio_index_path({filter: 'filepath_asc'})
    when :filepath_desc
      public_audio_index_path({filter: 'filepath_desc'})
    when :title_asc
      public_audio_index_path({filter: 'title_asc'})
    when :title_desc
      public_audio_index_path({filter: 'title_desc'})
    else
      public_audio_path
    end
  end
    

end
