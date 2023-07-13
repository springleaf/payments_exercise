class PaymentsController < ApplicationController
  def create
    loan = Loan.find(params[:loan_id])
    payment = loan.payments.build(payment_params)

    if payment.save
      render json: { success: 'Successfully created payments amount for a given loan.' }
    else
      render json: { errors: payment.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def payment_params
    params.require(:payment).permit(:payment_date, :amount)
  end
end