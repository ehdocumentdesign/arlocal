class Admin::AdministratorsController < AdminController


  def destroy
    # @administrator = Administrator.find!(params[:id])
    # @administrator.destroy
    flash[:alert] = 'Feature not implemented.'
    redirect_to action: :index
  end


  # def edit
  #   @administrator = Administrator.find!(params[:id])
  # end


  def index
    @administrators = Administrator.all
  end


end
