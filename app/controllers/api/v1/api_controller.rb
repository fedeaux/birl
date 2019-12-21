class Api::V1::ApiController < ApplicationController
  before_action :delay
  # before_action :authenticate_user!

  def delay
    # sleep 4
  end

  def current_context
    current_user.current_context
  end
end
