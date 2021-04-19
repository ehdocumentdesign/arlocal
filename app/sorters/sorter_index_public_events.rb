class SorterIndexPublicEvents


  extend InactiveRecordSingleton
  include Rails.application.routes.url_helpers  

  
  DATA = [
    # {
    #   id: 0,
    #   description: 'all events',
    #   symbol: :all
    # },
    # {
    #   id: 1,
    #   description: 'future events',
    #   symbol: :future
    # },
    # {
    #   id: 2,
    #   description: 'past events',
    #   symbol: :past
    # },
    {
      id: 3,
      description: 'upcoming events',
      symbol: :upcoming
    },
    {
      id: 4,
      description: 'past events with audio',
      symbol: :with_audio
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
    determine_public_url_from_symbol
  end


  
  private


  def determine_public_url_from_symbol
    case symbol
    when :all
      public_events_path({filter: 'all'})
    when :future
      public_events_path({filter: 'future'})
    when :past
      public_events_path({filter: 'past'})
    when :upcoming
      public_events_path({filter: 'upcoming'})
    when :with_audio
      public_events_path({filter: 'with_audio'})
    else
      public_events_path
    end    
  end


end
