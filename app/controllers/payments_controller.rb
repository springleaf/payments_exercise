class PaymentsController < ActionController::API
  before_action :set_loan

  rescue_from ActiveRecord::RecordNotFound do |exception|
    render json: 'not_found', status: :not_found
  end

  def index
    render json: @loan.payments
  end

  def show
    render json: @loan.payments.find(params[:id])
  end

  def create
    @payment = @loan.payments.build(payment_params)
    if @payment.save
      render json: @payment, status: :created
    else
      render json: { errors: @payment.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def set_loan
    @loan = Loan.find(params[:loan_id])
  end

  def payment_params
    params.require(:payment).permit(:payment_date, :amount)
  end
end
