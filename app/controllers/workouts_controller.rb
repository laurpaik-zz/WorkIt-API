# frozen_string_literal: true

class WorkoutsController < OpenReadController
  # before_action :set_workout, only: [:update, :destroy]

  # GET /workouts
  def index
    @workouts = Workout.all

    render json: @workouts
  end

  # GET /workouts/1
  def show
    render json: Workout.find(params[:id])
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_workout
    @workout = current_user.workouts.find(params[:id])
  end
  private :set_workout

  # Only allow a trusted parameter "white list" through.
  def workout_params
    params.require(:workout).permit(:name)
  end
  private :workout_params
end
