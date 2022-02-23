class Contact < ApplicationRecord
  validates_uniqueness_of :account_1, scope: :account_2
  validates :account_1, numericality: { other_than: 0 }
  validates :account_2, numericality: { other_than: 0 }

  scope :matches_for, -> id do
    matches = where("(account_1 = ? OR account_2 = ?)", id, id)

    account_ids = []
    matches.each do |match|
      new_id = match.account_1 == id ? match.account_2 : match.account_1
      account_ids << new_id
    end

    Account.where(id: account_ids)
  end

end
