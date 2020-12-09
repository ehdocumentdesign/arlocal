class MarkupParser
  extend InactiveRecordSingleton


  DATA = [
    {
      id: 0,
      description: 'No formatting',
      method: lambda { |text| text.to_s },
      symbol: :no_formatting
    },
    {
      id: 1,
      description: 'HTML Paragraph',
      method: lambda { |text| ApplicationController.helpers.tag.p(text.to_s) },
      symbol: :html_p
    },
    {
      id: 2,
      description: 'HTML Preformatted',
      method: lambda { |text| "<pre>\n" + text.to_s + "\n</pre>" },
      symbol: :html_pre
    },
    {
      id: 3,
      description: 'Markdown – Commonmarker',
      method: lambda { |text| CommonMarker.render_html(text.to_s) },
      symbol: :markdown_commonmarker
    },
    {
      id: 4,
      description: 'Simple Format – Rails',
      method: lambda { |text| ApplicationController.helpers.simple_format(text.to_s) },
      symbol: :simple_format_rails
    }
  ]

  HTML_CLASS_PREFIX = 'arl_markup_parser'


  attr_reader :id, :description, :html_class, :method, :symbol


  def initialize(parser)
    if parser
      @id = parser[:id]
      @description = parser[:description]
      @html_class = [ MarkupParser::HTML_CLASS_PREFIX, parser[:symbol].to_s ].join('_')
      @method = parser[:method]
      @symbol = parser[:symbol]
    end
  end



  public


  def call(text)
    @method.call(text)
  end


  def parse(text)
    call(text)
  end


end
