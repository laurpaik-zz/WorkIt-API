# frozen_string_literal: true

class AthletesController < OpenReadController
  before_action :set_athlete, only: [:update]

  # PATCH/PUT /athletes/1
  def update
    if @athlete.update(athlete_params)
      head :no_content
    else
      render json: @athlete.errors, status: :unprocessable_entity
    end
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_athlete
    @athlete = Athlete.find_by(id: params[:id], user: current_user)
  end
  private :set_athlete

  # Only allow a trusted parameter "white list" through.
  def athlete_params
    params.require(:athlete).permit(:given_name, :surname,
                                    :date_of_birth)
  end
  private :athlete_params
end
