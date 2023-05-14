class PostsController < ApplicationController
  before_action :authorized
  def index
    @posts = PostsQueryService.call(normalized_search_params).page params[:page]
  end

  def show
    @post = Post.find_by(id_param)
  end

  def edit
    @post = Post.find_by(id_param)
  end

  def update
    post = Post.find_by(id_param)
    if PostsUpdatePolicy.update?(current_user, post)
      PostsUpdateService.call(post, normalized_post_params)
      redirect_to edit_post_path_url(post.id)
    end
  end
  
  def delete
    post = Post.find_by(id_param)
    if PostsDeletionPolicy.delete?(current_user, post)
      PostsDeletionService.call(post)
      redirect_to posts_path
    end
  end

  def new
    @post = Post.new
  end
  
  def create
    if PostsCreationPolicy.create?(current_user)
      post = PostsCreationService.call(current_user, normalized_post_params)
      redirect_to post_path(post)
    end
  end

  private

  def id_param
    params.permit(:id)
  end

  def normalized_post_params
    normalized_post_params = {}
    normalized_post_params[:title] = post_params[:title]
    normalized_post_params[:body] = post_params[:body]
    normalized_post_params[:tag_names_array] = post_params[:tag_names_array]&.split(',')
    normalized_post_params
  end

  def post_params
    params.require(:post).permit(:title, :body, :tag_names_array)
  end

  def search_params
    params.permit(:title, :author_username, :tag_titles => {})
  end

  def normalized_search_params
    normalized_search_params = {}
    normalized_search_params[:title] = search_params[:title]
    normalized_search_params[:author_username] = search_params[:author_username]
    normalized_search_params[:tag_titles] = search_params[:tag_titles]&.keys
    normalized_search_params
  end
end
