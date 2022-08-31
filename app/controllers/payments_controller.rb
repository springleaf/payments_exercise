class PaymentsController < ActionController::API
  before_action :get_loan
  before_action :set_payment, only: [:show, :update, :destroy]

  rescue_from ActiveRecord::RecordNotFound do |exception|
    render json: 'not_found', status: :not_found
  end

  def index
    render json: @loan.payments
  end

  def show
    render json: @payment.to_json
  end

  def create
    @payment = @loan.payments.build(payment_params)
    if @payment.save
      render status: :created, json: @payment
    else
      render status: :unprocessable_entity, json: @payment.errors.full_messages
    end
  end

  private

  def payment_params
    params.require(:payment).permit(:amount, :loan_id)
  end

  def get_loan
    @loan ||= Loan.find(params[:loan_id])
  end

  def set_payment
    @payment ||= Payment.find(params[:id])
  end

end
