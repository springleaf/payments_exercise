class PaymentsController < ApplicationController
  def index
    render json: Loan.find(params[:loan_id]).payments
  end

  def show
    render json: Loan.find(params[:loan_id]).payments.find(params[:id])
  end

  def create
    loan = Loan.find(params[:loan_id])
    payment = loan.payments.build(payment_params)

    if payment.save
      render json: payment, status: :created
    else
      render json: payment.errors, status: :unprocessable_entity
    end
  end

  private

  def payment_params
    params.require(:payment).permit(:date, :amount)
  end
end
