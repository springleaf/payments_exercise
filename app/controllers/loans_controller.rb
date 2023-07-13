class LoansController < ApplicationController
  def index
    loans = Loan.all.map { |loan| loan.as_json.merge(outstanding_balance:loan.outstanding_balance) }
    render json:loans 
  end

  def show
    loan = Loan.find(params[:id])
    loan_hash = loan.as_json(except: [:created_at, :updated_at])
    render json: { loan: loan_hash }
  end
end
