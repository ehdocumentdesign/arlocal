class QueryEvents


  def initialize(args = {})
    arlocal_settings = (ArlocalSettings === args[:arlocal_settings]) ? args[:arlocal_settings] : QueryArlocalSettings.new.get
    @index_sorter_admin = SorterIndexAdminEvents.find(arlocal_settings.admin_index_events_sorter_id)
    @index_sorter_public = SorterIndexAdminEvents.find(arlocal_settings.public_index_events_sorter_id)

    @params = args[:params]

    @events = Event.all
  end



  public


  def action_admin_index(arg = nil)
    filter_method = (arg) ? arg : @params[:filter]

    case filter_method.to_s.downcase
    when 'datetime_asc'
      order_by_start_time_asc
    when 'datetime_desc'
      order_by_start_time_desc
    when 'only_future'
      all_future
    when 'only_past'
      all_past
    when 'title_asc'
      order_by_title_asc
    when 'title_desc'
      order_by_title_desc
    else
      all
    end
  end


  def action_admin_show_neighborhood(event, distance: 1)
    Event.neighborhood(event, collection: events_admin_index_ordered, distance: distance)
  end


  def action_public_index(arg = nil)
    filter_method = (arg) ? arg : @params[:filter]

    case filter_method.to_s.downcase
    when 'all'
      all.where(indexed: true, published: true)
    when 'future'
      all_future.where(indexed: true, published: true)
    when 'past'
      all_past.where(indexed: true, published: true)
    when 'upcoming'
      all_upcoming.where(indexed: true, published: true)
    when 'with_audio'
      all_with_audio.where(indexed: true, published: true)
    else
      all.where(indexed: true, published: true)
    end
  end


  def action_public_show
    @events.where(published: true).find_by_slug!(@params[:id])
  end


  def all
    @events
  end


  def all_future
    @events.where("datetime_utc > ?", Time.current.midnight).order(datetime_utc: :asc)
  end


  def all_past
    @events.where("datetime_utc < ?", Time.current).order(datetime_utc: :desc)
  end


  def all_upcoming
    @events.where(datetime_utc: Time.current.midnight...Time.current.next_month).order(datetime_utc: :asc)
  end


  def all_with_audio
    @events.where("audio_count >= 1").order(datetime_utc: :desc)
  end


  def find(id)
    @events.find_by_id!(id)
  end


  def find_by_slug(slug)
    @events.find_by_slug!(slug)
  end


  def find_including_resources(id)
    @events.includes(:pictures, :keywords).find!(id)
  end


  def order_by_start_time_asc
    @events.order(datetime_utc: :asc)
  end


  def order_by_start_time_desc
    @events.order(datetime_utc: :desc)
  end


  def order_by_title_asc
    @events.order(Event.arel_table[:title].lower.asc)
  end


  def order_by_title_desc
    @events.order(Event.arel_table[:title].lower.desc)
  end



  private


  def events_admin_index_ordered
    action_admin_index(@index_sorter_admin.symbol)
  end


  def events_public_index_ordered
    action_public_index(@index_sorter_public.symbol)
  end


end
