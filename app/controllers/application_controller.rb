Secret = Rails.env.production? ? ENV['JWT_SECRET_KEY'] : 'my$ecretK3y'

class ApplicationController < ActionController::API
  before_action :authorized

  def encode_token(payload)
    JWT.encode(payload, Secret)
  end

  def auth_header
    request.headers['Authorization']
  end

  def decoded_token
    if auth_header
      token = auth_header.split(' ')[1]
      begin
        JWT.decode(token, Secret, true, algorithm: 'HS256')
      rescue JWT::DecodeError
        nil
      end
    end
  end

  def authorized
    if decoded_token
      decoded_token[0]
    else
      render json: { message: 'Please log in' }, status: :unauthorized unless decoded_token
    end
  end
end
