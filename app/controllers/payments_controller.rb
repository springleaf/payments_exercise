class PaymentsController < ApplicationController
	before_action :set_current_loan

	def index
		render json: @loan.payments
	end

	def show
		render json: Payment.find(params[:id])
	end

	def create 
		@payment = @loan.payments.build(format_datetime(payment_params))
		if @payment.save
			render json: @payment, status: :created
		else
			render json: @payment, status: :bad_request
		end
	end

	private

	def payment_params
		params
		.require(:payment)
		.permit(:amount,:payment_date)
	end

	def set_current_loan
		@loan = Loan.find(params[:loan_id])
	end

	def format_date(attrs)
		attrs[:payment_date] = Time.at(attrs[:payment_date].to_i)
	end
end
