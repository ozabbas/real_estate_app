class Viewing < ApplicationRecord
  belongs_to :account
  belongs_to :property
  validates_presence_of :date

end
