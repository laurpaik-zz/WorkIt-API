# frozen_string_literal: true

class LogsController < ApplicationController
  before_action :set_log, only: [:show, :update, :destroy]

  # GET /logs
  def index
    @logs = Log.all

    render json: @logs
  end

  # GET /logs/1
  def show
    render json: @log
  end

  # POST /logs
  def create
    @log = Log.new(log_params)

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
    @log = Log.find(params[:id])
  end
  private :set_log

  # Only allow a trusted parameter "white list" through.
  def log_params
    params.require(:log).permit(:athlete_id, :workout_id, :date_completed)
  end
  private :log_params
end
