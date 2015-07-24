class CharactersController < ApplicationController
  wrap_parameters Character, include: [:abilities, :ability_strategy, :race_name]

  def index
    @characters = Character.most_recent_first
  end

  def new
    @character = Character.new
    respond_to do |format|
      format.html { render :show }
    end
  end

  def create
    character_form = CharacterForm.new(Character.new, character_params)
    character_form.save!
    respond_to do |format|
      format.html { redirect_to character_form.character }
      format.json { render json: character_form.character, serializer: CharacterSerializer }
    end
  end

  def show
    @character = Character.find params[:id]
  end

  def update
    character = Character.find params[:id]
    character_form = CharacterForm.new(character, character_params)
    character_form.save!
    respond_to do |format|
      format.html { redirect_to character }
      format.json { render json: character, serializer: CharacterSerializer }
    end
  end

  def check
    character_form = CharacterForm.new(Character.new, character_params)
    character_form.validate
    render json: character_form, serializer: CharacterSerializer
  end

  private

  def character_params
    params.require(:character).permit(CharacterForm.permitted_attributes)
  end
end
