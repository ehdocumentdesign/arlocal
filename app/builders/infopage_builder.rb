class InfopageBuilder


  attr_reader :infopage


  def initialize
    @infopage = Infopage.new
  end



  protected


  def self.build
    builder = new
    yield(builder)
    builder.infopage
  end


  def self.build_with_defaults
    self.build do |b|
      # b.assign_default_attributes
    end
  end


  def self.create(infopage_params)
    self.build do |b|
      # b.assign_default_attributes
      b.assign_given_attributes(infopage_params)
    end
  end


  public


  def assign_default_attributes
    @infopage.assign_attributes(params_default)
  end


  def assign_given_attributes(infopage_params)
    @infopage.assign_attributes(infopage_params)
  end
  

  private


  def params_default
    {
    }
  end


end
