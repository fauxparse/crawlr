class CharactersController < ApplicationController
  wrap_parameters Character, include: CharacterForm.wrapped_parameters

  def index
    @characters = Character.most_recent_first
  end

  def new
    @character = CharacterPresenter.new Character.new

    respond_to do |format|
      format.html { render :show }
    end
  end

  def create
    character_form = CharacterForm.new(Character.new, character_params)
    character_form.save!
    respond_to do |format|
      format.html { redirect_to character_form.character }
      format.json { render json: character_form.present, serializer: CharacterSerializer }
    end
  end

  def show
    @character = CharacterPresenter.new Character.find(params[:id])
    respond_to do |format|
      format.html
      format.json { render json: @character, serializer: CharacterSerializer }
    end
  end

  def update
    character = Character.find params[:id]
    character_form = CharacterForm.new(character, character_params)
    character_form.save!
    respond_to do |format|
      format.html { redirect_to character }
      format.json { render json: CharacterPresenter.new(character), serializer: CharacterSerializer }
    end
  end

  def check
    character = Character.new
    character_form = CharacterForm.new(character, character_params)
    character_form.validate
    render json: character_form.present, serializer: CharacterSerializer
  end

  private

  def character_params
    params.require(:character).permit(CharacterForm.permitted_attributes)
  end
end
