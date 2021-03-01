class StreamBuilder


  attr_reader :stream


  def initialize
    @stream = Stream.new
  end



  protected


  def self.build
    builder = new
    yield(builder)
    builder.stream
  end


  def self.build_with_defaults
    self.build do |b|
      b.assign_default_attributes
    end
  end


  def self.create(stream_params)
    self.build do |b|
      b.assign_default_attributes
      b.assign_given_attributes(stream_params)
    end
  end



  public


  def assign_default_attributes
    @stream.assign_attributes(params_default)
  end


  def assign_given_attributes(stream_params)
    @stream.assign_attributes(stream_params)
  end



  private


  def params_default
    {
      description_parser_id: MarkupParser.find_by_symbol(:markdown_commonmarker).id
    }
  end


end
