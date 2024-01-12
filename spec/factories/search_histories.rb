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
FactoryBot.define do
  factory :search_history do
    ip { FFaker::Internet.ip_v4_address }
    term { FFaker::Book.title }
  end
end
