# frozen_string_literal: true

class AthletesController < OpenReadController
  before_action :set_athlete, only: [:update, :destroy]

  # GET /athletes
  def index
    @athletes = Athlete.all

    render json: @athletes
  end

  # GET /athletes/1
  def show
    render json: Athlete.find(params[:id])
  end

  # POST /athletes
  def create
    @athlete = current_user.athletes.build(athlete_params)

    if @athlete.save
      render json: @athlete, status: :created
    else
      render json: @athlete.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /athletes/1
  def update
    if @athlete.update(athlete_params)
      head :no_content
    else
      render json: @athlete.errors, status: :unprocessable_entity
    end
  end

  # DELETE /athletes/1
  def destroy
    @athlete.destroy
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_athlete
    @athlete = current_user.athletes.find(params[:id])
  end
  private :set_athlete

  # Only allow a trusted parameter "white list" through.
  def athlete_params
    params.require(:athlete).permit(:given_name, :surname,
                                    :date_of_birth)
  end
  private :athlete_params
end
