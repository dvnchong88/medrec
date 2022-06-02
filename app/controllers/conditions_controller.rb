class ConditionsController < ApplicationController
  def new
    @condition = Condition.new
    authorize @condition
  end

  def create
    @condition = Condition.new(condition_params)
    @condition.patient = current_user.patient
    authorize @condition
    if @condition.save
      redirect_to condition_path(@condition)
    else
      render :new
    end
  end

  def show
    @condition = Condition.find(params[:id])
    authorize @condition
  end

  private

  def condition_params
    params.require(:condition).permit(:name)
  end
end
