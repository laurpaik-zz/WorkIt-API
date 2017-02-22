# frozen_string_literal: true

class LogsController < OpenReadController
  before_action :set_log, only: [:update, :destroy]

  # GET /logs
  def index
    @logs = Log.order(date_completed: :desc, id: :desc)

    render json: @logs
  end

  # GET /logs/1
  def show
    # render json: Log.find(params[:id])
    @logs = Log.where(athlete_id: current_user.id)
               .order(date_completed: :desc, id: :desc)
    render json: @logs
  end

  # POST /logs
  def create
    @log = current_user.logs.build(log_params)

    if @log.save
      render json: @log, status: :created
    else
      render json: @log.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /logs/1
  def update
    if @log.update(log_params)
      head :no_content
    else
      render json: @log.errors, status: :unprocessable_entity
    end
  end

  # DELETE /logs/1
  def destroy
    @log.destroy

    head :no_content
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_log
    @log = current_user.logs.find(params[:id])
  end
  private :set_log

  # Only allow a trusted parameter "white list" through.
  def log_params
    params.require(:log).permit(:date_completed, :workout_id, :athlete_id)
  end
  private :log_params
end
