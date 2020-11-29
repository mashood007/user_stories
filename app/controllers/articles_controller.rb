class ArticlesController < ApplicationController
  before_action :authenticate, except: [:index, :show]

  def index
    @articles = Article.page(params[:page]).per(10).includes(:user)
  end

  def new
    @categories = Category.all
    @article = Article.new
    @categories.each do |category|
      @article.article_categories.new(category_id: category.id)
    end
  end

  def create
    params[:article][:user_id] = session[:user_id]
    @article = Article.new(article_params)
    respond_to do |format|
      if @article.save
        format.html { redirect_to root_path, notice: 'success.' }
      else
        format.html { render :new }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    @article = Article.find(params[:id])
  end

  def destroy

  end

  private

  def article_params
    params[:article][:status] = params[:article][:status].to_i
    params.require(:article).permit(:title, :user_id, :content, :status, article_categories_attributes: [:id, :category_id])
  end
end
