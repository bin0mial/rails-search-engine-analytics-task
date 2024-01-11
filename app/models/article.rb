# == Schema Information
#
# Table name: articles
#
#  id         :integer          not null, primary key
#  body       :text             not null
#  title      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Article < ApplicationRecord
  validates :title, :body, presence: true

  def to_s
    title
  end
end
