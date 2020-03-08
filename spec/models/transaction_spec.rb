require 'rails_helper'

RSpec.describe Transaction, type: :model do
  it { should belong_to(:coin) }
  it { should validate_presence_of(:api_user) }
end
