class CharactersController < ApplicationController
  wrap_parameters Character, include: [:abilities, :ability_strategy]

  def index
    @characters = Character.most_recent_first
  end

  def new
    @character = Character.new
  end

  def show
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
