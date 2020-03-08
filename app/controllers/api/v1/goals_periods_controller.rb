class Api::V1::GoalsPeriodsController < Api::V1::ApiController
  def index
    @goals_periods = Goaler::Main.new(current_user, goaler_main_params).build
  end

  def goaler_main_params
    params.permit(:base_date)
  end
end
