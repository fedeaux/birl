class Api::V1::ChallengesController < Api::V1::ApiController
  before_action :set_challenge, only: %i[show update destroy]

  def index
    @challenges = current_user.challenges
  end

  def show; end

  def update
    if @challenge.update(challenge_params)
      render 'show', status: :ok
    else
      render 'show', status: :unprocessable_entuty
    end
  end

  def create
    @challenge = current_user.challenges.new challenge_params
    if @challenge.save
      render 'show', status: :created
    else
      render 'show', status: :unprocessable_entuty
    end
  end

  def destroy
    @challenge.destroy
  end

  private

  def set_challenge
    @challenge = current_user.challenges.find(params[:id])
  end

  def challenge_params
    params.require(:challenge).permit(:id, :name, :description, :user_id)
  end
end
