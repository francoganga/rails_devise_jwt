class Users::SessionsController < Devise::SessionsController
  respond_to :json
  skip_before_action :verify_authenticity_token

  private

  def respond_with(resource, _opts = {})
    if current_user
      render json: resource
    else
      log_in_failure
    end
  end

  def respond_to_on_destroy
    puts "respond_to_on_destroy>>>>>>>>>>>>>>>>>>>>>>>"
    puts current_user.inspect
    if current_user
      log_out_success
    else
      log_out_failure
    end
  end

  def log_out_success
    render json: { message: 'You are logged out.' }, status: :ok
  end

  def log_out_failure
    render json: { message: 'Unauthorized' }, status: :unauthorized
  end

  def log_in_failure
    render json: { message: 'Unauthorized' }, status: :unauthorized
  end
end
