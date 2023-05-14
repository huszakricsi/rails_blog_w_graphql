class CommentsController < ApplicationController
  before_action :authorized
  
  def create
    post = CommentsCreationService.call(current_user, comment_params[:post_id], comment_params[:body])
    redirect_to post_path(comment_params[:post_id])
  end

  private

  def comment_params
    params.permit(:post_id, :body)
  end
end
