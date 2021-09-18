class MarkupParser
  extend InactiveRecordSingleton


  DATA = [
    {
      id: 0,
      description: 'No formatting',
      method_parse: lambda { |text| text.to_s },
      method_sanitize: lambda { |text| ApplicationController.helpers.sanitize(text) },
      symbol: :no_formatting
    },
    {
      id: 1,
      description: 'HTML Paragraph',
      method_parse: lambda { |text| ApplicationController.helpers.tag.p(text.to_s) },
      method_sanitize: lambda { |text| ApplicationController.helpers.sanitize(text) },
      symbol: :html_p
    },
    {
      id: 2,
      description: 'HTML Preformatted',
      method_parse: lambda { |text| "<pre>\n" + text.to_s + "\n</pre>" },
      method_sanitize: lambda { |text| ApplicationController.helpers.sanitize(text) },
      symbol: :html_pre
    },
    {
      id: 3,
      description: 'Markdown – Commonmarker',
      method_parse: lambda { |text| CommonMarker.render_html(text.to_s) },
      method_sanitize: lambda { |text| ApplicationController.helpers.sanitize(text) },
      symbol: :markdown_commonmarker
    },
    {
      id: 4,
      description: 'Simple Format – Rails',
      method_parse: lambda { |text| ApplicationController.helpers.simple_format(text.to_s) },
      method_sanitize: lambda { |text| ApplicationController.helpers.sanitize(text) },
      symbol: :simple_format_rails
    },
    {
      id: 5,
      description: 'HTML iFrame',
      method_parse: lambda { |text| text.to_s },
      method_sanitize: lambda { |text| ApplicationController.helpers.sanitize(text, tags: [:iframe, :script]) },
      symbol: :html_iframe
    }
  ]

  HTML_CLASS_PREFIX = 'arl_markup_parser'


  protected


  def self.parse_sanitize_class(resource_text_props)
    parser = self.find(resource_text_props[:parser_id])
    { html_class: parser.html_class, sanitized_text: parser.parse_and_sanitize(resource_text_props[:text_markup]) }
  end



  public


  attr_reader :id, :description, :html_class, :method_parse, :method_sanitize, :symbol


  def initialize(parser)
    if parser
      @id = parser[:id]
      @description = parser[:description]
      @html_class = [ MarkupParser::HTML_CLASS_PREFIX, parser[:symbol].to_s ].join('_')
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
