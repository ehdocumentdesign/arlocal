class Admin::ArticlesController < AdminController


  def create
    @article = ArticleBuilder.new.default_with(article_params)
    if @article.save
      flash[:notice] = 'Article was successfully created.'
      redirect_to edit_admin_article_path(@article)
    else
      @form_metadata = FormArticleMetadata.new
      flash[:notice] = 'Article could not be created'
      render 'new'
    end
  end


  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    flash[:notice] = 'Article was destroyed.'
    redirect_to action: :index
  end


  def edit
    @article = Article.find(params[:id])
    @article_neighbors = QueryArticles.new(arlocal_settings: @arlocal_settings).action_admin_show_neighborhood(@article)
    @form_metadata = FormArticleMetadata.new(pane: params[:pane])
  end


  def index
    @articles = Article.all
  end


  def new
    @article = ArticleBuilder.new.default
    @form_metadata = FormArticleMetadata.new
  end


  def show
    @article = Article.find(params[:id])
    @article_neighbors = QueryArticles.new(arlocal_settings: @arlocal_settings).action_admin_show_neighborhood(@article)
  end


  def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
      flash[:notice] = 'Article was successfully created.'
      redirect_to edit_admin_article_path(@article)
    else
      @form_metadata = FormArticleMetadata.new(pane: params[:pane])
      flash[:notice] = 'Article could not be created'
      render 'edit'
    end
  end



  private


  def article_params
    params.require(:article).permit(
      :author,
      :copyright_parser_id,
      :copyright_text_markup,
      :date_released,
      :indexed,
      :parser_id,
      :published,
      :text_markup,
      :title
    )
  end


end
