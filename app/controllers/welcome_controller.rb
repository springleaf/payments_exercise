class WelcomeController < ApplicationController
  def index
  @payments = Payment.find(1)
  byebug
  end
end
