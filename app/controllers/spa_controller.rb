class SpaController < ApplicationController
  def index
    @body_class = 'birl-spa'
  end

  def acme
    render plain: 'rWJMshGiEIOoSHdhAuZXU7XLjLxwZgonfp-ogI5vJsA.GpYZBlg_xhqXY7tEW8Qg0ZRPuWa-tEa8h_mkfELINDA'
  end
end
