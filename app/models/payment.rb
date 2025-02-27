class Payment < ActiveRecord::Base
  belongs_to :loan

  before_create :validate_and_create_payment

  private

  def validate_and_create_payment
    ActiveRecord::Base.transaction do
      loan.with_lock do
        if amount > loan.outstanding_balance
          errors.add(:amount, "Payment amount exceeds loan balance")
          throw :abort
        end
      end
    end
  end
end
