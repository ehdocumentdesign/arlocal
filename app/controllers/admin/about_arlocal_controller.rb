class Admin::AboutArlocalController < AdminController


  def markup_types
    @markup_examples = ArlocalMarkupExamples::MARKUP_EXAMPLES
  end


  def index
  end


  def release_notes
  end


  def whats_new
  end


end
