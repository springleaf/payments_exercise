class LoansController < ActionController::API

  respond_to :json

  rescue_from ActiveRecord::RecordNotFound do |exception|
    render json: 'not_found', status: :not_found
  end

  def index
    @loans = Loan.all
    respond_with(@loans, status: :ok)
  end

  def create
    @loan = Loan.create(loan_params)
    if @loan.save
      respond_with(@loan, status: :created)
    else
      render json: @loan.errors.full_messages
    end
  end

  def show
    @loan = Loan.find(params[:id])
    respond_with(@loan, status: :ok)
  end

  private

  def loan_params
    params.require(:loan).permit( :funded_amount)
  end

end
