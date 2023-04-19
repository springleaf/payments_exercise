class PaymentsController < ActionController::API
  before_action :set_loan
  rescue_from ActiveRecord::RecordNotFound do |exception|
    render json: { errors: ['not_found'] }, status: :not_found
  end

  def index
    @payments = @loan.payments
    render json: @payments
  end


  def show
    @payment = @loan.payments.find(params[:id])
    render json: @payment
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
    params.require(:payment).permit(:amount, :payment_date)
  end
end
