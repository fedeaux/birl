class Api::V1::ChallengesController < Api::V1::ApiController
  before_action :set_challenge, only: [:show, :update]

  def index
    @challenges = Challenge.all
  end

  def show
  end

  def update
    if @challenge.update(challenge_params)
      render 'show', status: :ok
    else
      render status: :unprocessable_entuty
    end
  end

  def create
    @challenge = Challenge.new challenge_params
    if @challenge.save
      render 'show', status: :created
    else
      render status: :unprocessable_entuty
    end
  end

  private

  def set_challenge
    @challenge = Challenge.find(params[:id])
  end

  def challenge_params
    params.require(:challenge).permit(:id, :name, :description, :user_id)
  end
end
