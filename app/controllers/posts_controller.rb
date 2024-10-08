class PostsController < ApplicationController
before_action :set_post, only: %i[ show edit update destroy ]

  # GET /posts or /posts.json
  def index
    sort_options = {
      'title_asc'       => { title: :asc },
      'title_desc'      => { title: :desc },
      'created_at_asc'  => { created_at: :asc },
      'created_at_desc' => { created_at: :desc },
      'most_popular'    => 'COUNT(comments.id) DESC'
    }

    sort_option = sort_options[params[:sort]] || { created_at: :desc }

    @posts = Post.left_joins(:comments)
                 .group(:id)
                 .order(sort_option)
                 .search(params[:q])
                 .page(params[:page])
                 .per(10)

    @total_pages = @posts.total_pages
    @current_page = @posts.current_page

    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end



  # GET /posts/1 or /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts or /posts.json
  def create
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to post_url(@post), notice: "Post was successfully created." }
        format.json { render :show, status: :created, location: @post }
      else
        format.html do
          flash[:alert] = @post.errors.full_messages.to_sentence
          render :new, status: :unprocessable_entity
        end
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to post_url(@post), notice: "Post was successfully updated." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post.destroy

    respond_to do |format|
      format.turbo_stream do
        flash.now[:notice] = 'Post was successfully destroyed.'
        render turbo_stream: turbo_stream.remove(@post) + turbo_stream.replace("flash-messages", partial: "shared/flash_messages")
      end
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:title, :body)
    end
end
