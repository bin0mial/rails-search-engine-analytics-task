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
require 'rails_helper'

RSpec.describe Article, type: :model do
  describe 'validations' do
    %i[title body].each do |attribute|
      it { is_expected.to validate_presence_of attribute }
    end
  end
end
