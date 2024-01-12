# frozen_string_literal: true

# == Schema Information
#
# Table name: articles
#
#  id         :bigint           not null, primary key
#  body       :text             not null
#  title      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Article < ApplicationRecord
  RANSACKABLE_ATTRIBUTES = %w[title body].freeze

  # Validations
  validates :title, :body, presence: true

  # Class methods
  def self.ransackable_attributes(*)
    RANSACKABLE_ATTRIBUTES
  end

  def to_s
    title
  end
end
