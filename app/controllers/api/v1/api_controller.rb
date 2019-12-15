class Api::V1::ApiController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :delay

  def delay
    # sleep 4
  end

  def current_context
    current_user.context 'bodybuilding'
  end
end
