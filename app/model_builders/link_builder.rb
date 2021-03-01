class LinkBuilder


  attr_reader :link


  def initialize
    @link = Link.new
  end



  protected


  def self.build
    builder = new
    yield(builder)
    builder.link
  end


  def self.build_with_defaults
    self.build do |b|
      b.assign_default_attributes
    end
  end


  def self.create(link_params)
    self.build do |b|
      b.assign_default_attributes
      b.assign_given_attributes(link_params)
    end
  end



  public


  def assign_default_attributes
    @link.assign_attributes(params_default)
  end


  def assign_given_attributes(link_params)
    @link.assign_attributes(link_params)
  end



  private


  def params_default
    {
      details_parser_id: MarkupParser.find_by_symbol(:simple_format_rails).id,
    }
  end


end
