class LoansController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  def index
    loans = Loan.all
    render json: loans.as_json(methods: :outstanding_balance, include: :payments)
  end

  def show
    loan = Loan.find(params[:id])
    render json: loan.as_json(methods: :outstanding_balance, include: :payments)
  end

  private

  def not_found(exception)
    render json: { error: "Not Found" }, status: :not_found
  end
end