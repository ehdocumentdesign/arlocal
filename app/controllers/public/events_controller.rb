class Public::EventsController < PublicController


  def index
    if params[:filter] == nil
      params[:filter] = SorterIndexPublicEvents.find(@arlocal_settings.public_index_events_sorter_id).symbol
    end
    events = QueryEvents.new(arlocal_settings: @arlocal_settings, params: params).action_public_index
    index_collection_render(events)
  end


  def index_collection_render(events)
    if events.empty?
      render :index_nil
    else
      case events
      when ActiveRecord::Relation
        @events = events
        render :index_array
      when Array
        @events = events
        render :index_array
      when Hash
        @events_calendar = events
        render :index_hash
      else
        render :index_nil
      end
    end
  end


  def show
    @event = QueryEvents.find_public(params[:id])
  end


end
