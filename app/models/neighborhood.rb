class Neighborhood


  include Rails.application.routes.url_helpers


  attr_reader :following, :preceeding


  def initialize(neighbors)
    @following = [neighbors[:following]].flatten
    @preceeding = [neighbors[:preceeding]].flatten
  end


  public


  def next
    @following[0]
  end


  def previous
    @preceeding[0]
  end




  # TODO: All this might be obsolete now that individual individual resource helpers explicitly handle buttons.
  # Correction: this does seem redundant, but it is still in use by `shared/resource_nav_by_item`
  # for navigating between neighboring resource items.


  def closest_admin_paths
    { next_path: next_path_admin, previous_path: previous_path_admin }
  end


  def closest_public_paths
    { next_path: next_path_public, previous_path: previous_path_public }
  end


  def next_path_admin_edit
    determine_admin_edit_path(self.next)
  end


  def next_path_admin_show
    determine_admin_show_path(self.next)
  end


  def next_path_public
    determine_public_show_path(self.next)
  end


  def previous_path_admin_edit
    determine_admin_edit_path(self.previous)
  end


  def previous_path_admin_show
    determine_admin_show_path(self.previous)
  end


  def previous_path_public
    determine_public_show_path(self.previous)
  end


  def following_paths_public
    @following.map { |neighbor| determine_public_path(neighbor) }
  end


  def preceeding_paths_public
    @preceeding.map { |neighbor| determine_public_path(neighbor) }
  end



  private


  def determine_admin_edit_path(neighbor)
    case neighbor
    when Album
      edit_admin_album_path(neighbor.id_admin)
    when Article
      edit_admin_article_path(neighbor.id_admin)
    when Audio
      edit_admin_audio_path(neighbor.id_admin)
    when Event
      edit_admin_event_path(neighbor.id_admin)
    when Keyword
      edit_admin_keyword_path(neighbor.id_admin)
    when Link
      edit_admin_link_path(neighbor.id_admin)
    when Picture
      edit_admin_picture_path(neighbor.id_admin)
    when Video
      edit_admin_video_path(neighbor.id_admin)
    end
  end


  def determine_admin_show_path(neighbor)
    case neighbor
    when Album
      admin_album_path(neighbor.id_admin)
    when Audio
      admin_audio_path(neighbor.id_admin)
    when Article
      admin_article_path(neighbor.id_admin)
    when Event
      admin_event_path(neighbor.id_admin)
    when Keyword
      admin_keyword_path(neighbor.id_admin)
    when Link
      admin_link_path(neighbor.id_admin)
    when Picture
      admin_picture_path(neighbor.id_admin)
    when Video
      admin_video_path(neighbor.id_admin)
    end
  end


  def determine_public_show_path(neighbor)
    case neighbor
    when Album
      public_album_path(neighbor.id_public)
    when Event
      public_event_path(neighbor.id_public)
    when Picture
      public_picture_path(neighbor.id_public)
    when Video
      public_video_path(neighbor.id_public)
    end
  end



end
