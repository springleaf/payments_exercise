class PaymentsController < ApplicationController
  before_action :set_payment, only: %i[ show ]

  # GET /payments/1
  # GET /payments/1.json
  def show
    render json: @payment
  end

  # POST /payments
  # POST /payments.json
  def create
    @payment = Payment.new(payment_params)

    begin
      ActiveRecord::Base.transaction do
        @payment.save!
        Loan.where(id: @payment.loan_id).update_all(['total_payments = COALESCE(total_payments, 0) + ?', @payment.amount])
      end
    rescue StandardError
      render json: @payment.errors, status: :unprocessable_entity
    else
      render json: @payment, status: :created
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_payment
      @payment = Payment.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def payment_params
      params.require(:payment).permit(:amount, :loan_id).tap do |p|
        p[:date] = Time.current
      end
    end
end
