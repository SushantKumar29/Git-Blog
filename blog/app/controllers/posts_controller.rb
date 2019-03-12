class PostsController < ApplicationController

	# http_basic_authenticate_with name: "susantas", password: "mindfire",
	# except: [:index, :show]
	
	before_action :find_post, only: [:update, :edit, :destroy]
	before_action :authenticate_user!, except: [:index, :show]

	rescue_from ActiveRecord::RecordNotFound, with: :record_not_found


	def index
		@posts = Post.all.order(created_at: :DESC)
	end

	def new
		@post = current_user.posts.new
	end	

	def create
		@post = current_user.posts.new(post_params)
		if @post.save
			redirect_to @post, :notice => "Post Saved Successfully"
		else
			render 'new'
		end
	end

	def show
		render locals: {
			post: Post.find_by!(id: params[:id])
		}
	end

	def edit
		
	end

	def update
		if @post.update(post_params)
			redirect_to @post, :notice => "Post Updated Successfully"
		else
			render 'edit'
		end
	end

	def destroy
		@post.destroy
		redirect_to posts_path, :notice => "Post Removed Successfully"
	end

	private

	def post_params
		params.require(:post).permit(:title, :content)
	end

	def find_post
		@post = Post.find_by!(id: params[:id])
	# rescue
	# 	post_not_found
	end

	def record_not_found
      render plain: "404 Not Found", status: 404
    end


# This is a Test for Git


end


