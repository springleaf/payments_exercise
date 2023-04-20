class LoansController < ApplicationController
  def index
    render json: Loan.all
  end

  def show
    render json: Loan.find(params[:id])
  end
end
