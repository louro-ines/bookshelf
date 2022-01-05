class ApplicationController < ActionController::API
  #exception handling
  rescue_from ActiveRecord::RecordNotDestroyed, with: :not_destroyed

  private

  def not_destroyed(error)
    render json: { errors: error.record.errors }, status: :unprocessable_entity
  end
end
