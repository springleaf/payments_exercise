class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound do |exception|
    Rails.logger.error(exception.message)
    render json: { errors: ['not_found'] }, status: :not_found
  end
end
