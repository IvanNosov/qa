require 'rails_helper'

describe Question do
  it { should have_many(:answers).dependent(:destroy) }
  it { should belong_to(:user) }
  it { should have_many :attachments }
  it { should have_many(:votes) }

  it { should validate_presence_of :title }
  it { should validate_presence_of :body }

  it { should accept_nested_attributes_for :attachments }
end
