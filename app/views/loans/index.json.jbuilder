json.status true
json.loans @loans do |l|
  json.partial! 'loans/loan_detail', loan: l
end
