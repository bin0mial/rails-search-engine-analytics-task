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
require 'rails_helper'

RSpec.describe SearchHistory, type: :model do
  describe 'validations' do
    %i[ip term].each do |attribute|
      it { is_expected.to validate_presence_of(attribute) }
    end
  end
end
