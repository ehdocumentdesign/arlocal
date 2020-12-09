class ActionDispatch::Routing::Mapper
  def draw(routes_name)
    instance_eval(File.read(Rails.root.join("config/routes/routes_#{routes_name}.rb")))
  end
end

Rails.application.routes.draw do
  draw :public
  draw :admin
  draw :devise
end
