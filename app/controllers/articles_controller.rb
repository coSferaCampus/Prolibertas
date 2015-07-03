class ArticlesController < ApplicationController
  respond_to :json
  load_and_authorize_resource param_method: :article_params

  def show
    respond_with @article
  end

  def index
    @articles = Person.find(params[:person_id]).articles
    respond_with @articles
  end

  def create
    @article = Person.find(params[:person_id]).articles.create(article_params)
    respond_with @article
  end

  def update
    @article.update_attributes(article_params)
    respond_with @article
  end

  def destroy
    @article.destroy
    respond_with @article
  end


  private

  def article_params
    params.require(:article).permit(
      :id, :type, :amount, :requested, :dispensed, :observations
      )
  end
end
