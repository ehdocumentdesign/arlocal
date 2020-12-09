class SorterEventPictures
  extend InactiveRecordSingleton
  

  DATA = [
    {
      id: 0,
      description: 'coverpicture first, then date/time cascade (old - new)',
      method: lambda { |event_pictures| SorterEventPictures.cover_datetime_asc(event_pictures) },
      symbol: :cover_datetime_asc
    },
    {
      id: 1,
      description: 'coverpicture first, then date/time cascade (new - old)',
      method: lambda { |event_pictures| SorterEventPictures.cover_datetime_desc(event_pictures) },
      symbol: :cover_datetime_desc
    },
    {
      id: 2,
      description: 'coverpicture first, then manual order (low - high)',
      method: lambda { |event_pictures| SorterEventPictures.cover_manual_asc(event_pictures) },
      symbol: :cover_manual_asc
    },
    {
      id: 3,
      description: 'coverpicture first, then manual order (high - low)',
      method: lambda { |event_pictures| SorterEventPictures.cover_manual_desc(event_pictures) },
      symbol: :cover_manual_desc
    }
  ]


  attr_reader :id, :description, :method, :symbol


  def initialize(sorter)
    if sorter
      @id = sorter[:id]
      @description = sorter[:description]
      @method = sorter[:method]
      @symbol = sorter[:symbol]
    end
  end



  public


  def call(event_pictures)
    @method.call(event_pictures)
  end


  def sort(event_pictures)
    call(event_pictures)
  end



  protected
  
  
  def self.cover_datetime_asc(event_pictures)
    event_pictures.order('event_pictures.is_coverpicture DESC').joins(:picture).order('pictures.datetime_cascade_value ASC')
  end


  def self.cover_datetime_desc(event_pictures)
    event_pictures.order('event_pictures.is_coverpicture DESC').joins(:picture).order('pictures.datetime_cascade_value DESC')
  end
  
  
  def self.cover_manual_asc(event_pictures)
    event_pictures.order('event_pictures.is_coverpicture DESC').order('event_pictures.event_order ASC')
  end
  
  
  def self.cover_manual_desc(event_pictures)
    event_pictures.order('event_pictures.is_coverpicture DESC').order('event_pictures.event_order DESC')
  end
  

end
