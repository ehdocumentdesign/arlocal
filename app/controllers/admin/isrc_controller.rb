class Admin::IsrcController < AdminController


  def review
    @resources = (Audio.all.map { |a| a }) + (Video.all.map { |v| v })
    @resources.sort_by!{ |a| a.isrc }
  end


  def update
  end


end
