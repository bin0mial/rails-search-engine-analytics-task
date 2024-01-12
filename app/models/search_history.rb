# == Schema Information
#
# Table name: search_histories
#
#  id         :integer          not null, primary key
#  ip         :string           not null
#  term       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class SearchHistory < ApplicationRecord
  validates :ip, :term, presence: true
end
