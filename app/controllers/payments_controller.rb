class PaymentsController < ApplicationController
	# before_action :set_current_loan

	# rescue_from ActiveRecord::RecordNotFound do |exception|
	# 	render json: 'not_found', status: :not_found
	# end
  
	def index
    byebug
		# render json: @loan.payments
	end
  
  def new
    @payment = Payment.new
  end

	def show
		# render json: Payment.find(params[:id])
	end

	def create 
    byebug
    @payment = Payment.new
    @payment.amount = params.require(:amount)
    @payment.save
    redirect_to @payment
		# @payment = @loan.payments.build(format_datetime(payment_params))
		# if @payment.save
		# 	render json: @payment, status: :created
		# else
		# 	render json: @payment.errors, status: :bad_request
		# end
	end

  def show
    @payments = Payment.find(1)
    @payments.attributes.inspect
    byebug
    logger.debug "New Payment: #{@payments.attributes.inspect}"
  end

	private

	def payment_params
		# params.require(:amount).permit(:amount1)
	end

  

	def set_current_loan
		@loan = Loan.find(params[:loan_id])
	end

	def format_datetime(attrs)
		attrs[:payment_date] = attrs[:payment_date]&.to_datetime || DateTime.now
		attrs
	end
end
