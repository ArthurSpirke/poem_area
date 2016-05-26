class ShortStoriesController < ApplicationController

  before_action :set_short_story, only: [:show, :edit, :update, :destroy, :publish, :unpublish]

  def index
    tag_title = params[:tag_title]
    @short_stories = ShortStory.all
    @short_stories = @short_stories.by_tag_title(tag_title) if tag_title.present?
  end

  def show
  end

  def new
    @short_story = ShortStory.new
  end

  def create
    @short_story = ShortStory.new(short_story_params)
    if @short_story.save
      redirect_to short_story_path(@short_story)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @short_story.update(short_story_params)
      redirect_to short_story_path(@short_story)
    else
      render :edit
    end
  end

  def destroy
    @short_story.destroy
    redirect_to short_stories_path
  end

  def publish
    @short_story.publish!
    redirect_to short_story_path(@short_story)
  end

  def unpublish
    @short_story.unpublish!
    redirect_to short_story_path(@short_story)
  end

  private

  def set_short_story
    @short_story = ShortStory.find(params[:id])
  end

  def short_story_params
    params.require(:short_story).permit(:id, :author_id, :published, :title, :description, :content)
  end

end
