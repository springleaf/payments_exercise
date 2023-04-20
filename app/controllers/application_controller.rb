class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound do |exception|
    render json: { errors: ['not_found'] }, status: :not_found
  end
end
