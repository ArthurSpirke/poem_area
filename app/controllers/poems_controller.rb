class PoemsController < ApplicationController

  before_action :set_poem, only: [:show, :edit, :update, :destroy, :publish, :unpublish]

  def index
    tag_title = params[:tag_title]
    @poems = Poem.all
    @poems = @poems.by_tag_title(tag_title) if tag_title.present?
  end

  def show
  end

  def new
    @poem = Poem.new
  end

  def create
    @poem = Poem.new(poem_params)
    if @poem.save
      redirect_to poem_path(@poem)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @poem.update(poem_params)
      redirect_to poem_path(@poem)
    else
      render :edit
    end
  end

  def destroy
    @poem.destroy
    redirect_to poems_path
  end

  def publish
    @poem.publish!
    redirect_to poem_path(@poem)
  end

  def unpublish
    @poem.unpublish!
    redirect_to poem_path(@poem)
  end

  private

  def set_poem
    @poem = Poem.find(params[:id])
  end

  def poem_params
    params.require(:poem).permit(:id, :author_id, :published, :title, :metaphor, :content)
  end

end
