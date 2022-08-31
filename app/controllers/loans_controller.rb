class LoansController < ActionController::API
  before_action :set_loan, only: [:show, :update, :destroy]

  rescue_from ActiveRecord::RecordNotFound do |exception|
    render json: 'not_found', status: :not_found
  end

  def index
    render json: Loan.all
  end

  def show
    render json: @loan
  end

  private

  def set_loan
    @loan ||= Loan.find(params[:id])
  end
end
