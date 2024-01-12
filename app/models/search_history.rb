# == Schema Information
#
# Table name: search_histories
#
#  id           :integer          not null, primary key
#  ip           :string           not null
#  result_count :bigint           default(0), not null
#  term         :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class SearchHistory < ApplicationRecord
  validates :ip, :term, :result_count, presence: true
  validates :result_count, numericality: { greater_than_or_equal_to: 0, only_integer: true }
end
