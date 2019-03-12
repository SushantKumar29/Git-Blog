class CommentsController < ApplicationController

	# http_basic_authenticate_with name:"susantas", passwor: "mindfire", only: :destroy

	before_action :find_posts, only: [:create,:destroy]
	before_action :authenticate_user!
	def create
		@comment = @post.comments.create(params[:comment].permit(:comment))
		if @comment.valid?

			@comment.user_id = current_user.id
			if @comment.save
				redirect_to post_path(@post)
			else
				render nothing: true
			end
		else
			redirect_to post_path(@post), :alert => 'Comment must be within 2-200 characters.'
		end
	end

	def destroy
		# @post = Post.find(params[:post_id])
		@comment = @post.comments.find(params[:id])
 		@comment.destroy
		redirect_to post_path(@post)
	end

	private
		
	def find_posts
		@post = Post.find(params[:post_id]) 
	end

end
