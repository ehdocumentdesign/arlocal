class ArticleBuilder


  attr_reader :article


  def initialize
    @article = Article.new
  end



  protected


  def self.build
    builder = new
    yield(builder)
    builder.article
  end


  def self.build_with_defaults
    self.build do |b|
      b.assign_default_attributes
    end
  end


  def self.create(article_params)
    self.build do |b|
      b.assign_default_attributes
      b.assign_given_attributes(article_params)
    end
  end



  public


  def assign_default_attributes
    @article.assign_attributes(params_default)
  end


  def assign_given_attributes(article_params)
    @article.assign_attributes(article_params)
  end



  private


  def params_default
    {
      indexed: true,
      parser_id: MarkupParser.find_by_symbol(:simple_format_rails).id,
      published: false
    }
  end


end
