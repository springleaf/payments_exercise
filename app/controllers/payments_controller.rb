class PaymentsController < ApplicationController
	before_action :set_current_loan

	rescue_from ActiveRecord::RecordNotFound do |exception|
		render json: 'not_found', status: :not_found
	end

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
			render json: @payment.errors, status: :bad_request
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

	def format_datetime(attrs)
		attrs[:payment_date] = attrs[:payment_date]&.to_datetime || DateTime.now
		attrs
	end
end
