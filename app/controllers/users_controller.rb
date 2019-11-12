class UsersController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    token = Rails.application.credentials[:api_token]
    if token == params[:token_id]
      User.create(email: params[:email], password: params[:password])
    end
    head :ok, content_type: "text/html"
  end
end
