class PaymentsController < ApplicationController
    def create
      loan = Loan.find(params[:loan_id])
      payment = loan.payments.build(payment_params)
  
      if payment.save
        render json: payment, status: :created
      else
        render json: { errors: payment.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    def index
      loan = Loan.find(params[:loan_id])
      render json: loan.payments
    end
  
    def show
      payment = Payment.find(params[:id])
      render json: payment
    end
  
    private
  
    def payment_params
      params.require(:payment).permit(:amount, :payment_date)
    end
  end