class FormAdministratorsRegistrationsMetadata


  attr_reader :nav_categories, :partial_name, :tab_name


  def initialize(pane: :name)
    pane = ((pane == nil) ? :name : pane.to_sym.downcase)

    @nav_categories = FormAdministratorsRegistrationsMetadata.categories
    @partial_name = determine_partial_name(pane)
    @tab_name = determine_tab_name(pane)
  end


  def self.categories
    [
      :password,
      :profile
    ]
  end


  private


  def determine_partial_name(pane)
    case pane
    when :password
      'form_password'
    when :profile
      'form_profile'
    else
      'form_profile'
    end
  end


  def determine_tab_name(pane)
    if FormAdministratorsRegistrationsMetadata.categories.include?(pane)
      pane
    else
      :profile
    end
  end


end
