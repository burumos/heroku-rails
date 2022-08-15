class Nico::ConditionController < ApplicationController
  before_action :logged_in

  def create
    condition = NicoCondition.new condition_params.merge({ user_id: @user.id })
    raise StandardError, 'Invalid data.' unless condition.valid?

    condition.save
    render json: { result: 'success', data: condition }
  end

  def destroy
    condition = NicoCondition.find(params[:id])
    raise StandardError, 'You don\'t have permission.' if condition.user_id != @user.id

    condition.destroy
    render json: { result: 'success', condition: }
  end

  private

  def condition_params
    params.permit(:query, :limit, :minimum_views)
  end
end
