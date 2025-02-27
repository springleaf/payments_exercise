class LoansController < ApplicationController

  def index
    render json: Loan.all.as_json(methods: :outstanding_balance)
  end

  def show
    render json: Loan.find(params[:id]).as_json(methods: :outstanding_balance)
  end
end
