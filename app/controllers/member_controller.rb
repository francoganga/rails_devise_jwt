class MemberController < ApplicationController
  before_action :authenticate_user!

  def show
    user = get_user_from_token
    if user
      render json: {
        message: 'If you see this you are in!!',
        user: user
      }
    else
      render json: { message: 'Unauthorized'}, status: :Unauthorized
    end
  end

  private

  def get_user_from_token
    puts "aca llega"
    jwt_payload = JWT.decode(request.headers['Authorization'].split(' ')[1],
                             ENV['DEVISE_SECRET_KEY']).first
    puts "JWT_PAYLOAD>>>>>>>>>>>>>>>>>>>>>>>>>>"
    puts jwt_payload
    user_id = jwt_payload['sub']
    user = User.find(user_id.to_s)
  end
end
