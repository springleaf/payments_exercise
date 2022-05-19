class PaymentsController < ActionController::API

  respond_to :json

  rescue_from ActiveRecord::RecordNotFound do |exception|
    render json: 'not_found', status: :not_found
  end

  def create
    @payment = Payment.create(payment_params)
    if @payment.save
      # render json: @loan
      respond_with(@payment, status: :created)
    else
      render json: @payment.errors.full_messages
    end
  end

  private

  def payment_params
    params.require(:payment).permit( :loan_id, :amount, :payment_date)
  end

end
