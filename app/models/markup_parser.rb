class MarkupParser
  extend InactiveRecordSingleton


  DATA = [
    {
      id: 0,
      categories: [:admin, :public],
      description: 'No formatting',
      method_parse: lambda { |text| text.to_s },
      method_sanitize: lambda { |text| ApplicationController.helpers.sanitize(text) },
      symbol: :no_formatting
    },
    {
      id: 3,
      categories: [:admin, :public],
      description: 'Markdown (commonmarker)',
      method_parse: lambda { |text| CommonMarker.render_html(text.to_s) },
      method_sanitize: lambda { |text| ApplicationController.helpers.sanitize(text) },
      symbol: :markdown_commonmarker
    },
    {
      id: 4,
      categories: [:admin, :public],
      description: 'Simple Format (rails)',
      method_parse: lambda { |text| ApplicationController.helpers.simple_format(text.to_s) },
      method_sanitize: lambda { |text| ApplicationController.helpers.sanitize(text) },
      symbol: :simple_format_rails
    },
    {
      id: 5,
      categories: [:admin],
      description: 'HTML embed',
      method_parse: lambda { |text| text.to_s },
      method_sanitize: lambda { |text| text.html_safe },
      symbol: :html_embed
    }
  ]


  protected


  def self.html_class_prefix
    'arl_markup_parser'
  end


  def self.parse_sanitize_class(resource_text_props)
    parser = MarkupParser.find(resource_text_props[:parser_id])
    { html_class: parser.html_class, sanitized_text: parser.parse_and_sanitize(resource_text_props[:text_markup]) }
  end



  public


  attr_reader :id, :description, :html_class, :method_parse, :method_sanitize, :symbol


  def initialize(parser)
    if parser
      @id = parser[:id]
      @description = parser[:description]
      @html_class = [MarkupParser.html_class_prefix, parser[:symbol].to_s].join('_')
      @method_parse = parser[:method_parse]
      @method_sanitize = parser[:method_sanitize]
      @symbol = parser[:symbol]
    end
  end


  def parse(text)
    @method_parse.call(text)
  end


  def parse_and_sanitize(text)
    sanitize(parse(text))
  end


  def sanitize(text)
    @method_sanitize.call(text)
  end



end
