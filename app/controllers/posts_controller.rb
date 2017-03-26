class PostsController < ApplicationController
	before_filter :authenticate_user!, :except => [:index]
  def new
  	@post = Post.new
  end

  def index
  	@posts = Post.all
  end

  def show
  	@post = Post.find_by(params[:id])
  end

	def create
		@post = Post.new(permit_post)
		if @post.save
			flash[:success] = "Success!"
			redirect_to post_path(@post)
		else
			flash[:error] = @post.erros.full_messages
			redirect_to new_post_path
		end

	end

  private
  def permit_post
  	params.require(:post).permit(:description, :image)
  end
end
