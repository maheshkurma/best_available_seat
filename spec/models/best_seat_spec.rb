require 'rails_helper'

RSpec.describe BestSeat, type: :model do
  it 'has a AVAILABLE constant' do
    expect(BestSeat::AVAILABLE).not_to be_nil
  end

  it 'has a RESERVED constant' do
    expect(BestSeat::RESERVED).not_to be_nil
  end

  it 'has a EXCEPTION_HANDLER constant' do
    expect(BestSeat::EXCEPTION_HANDLER).not_to be_nil
  end

  it 'has a STATUS constant' do
    expect(BestSeat::STATUS).not_to be_nil
  end

  it 'has a ROW_LIMIT_MAX constant' do
    expect(BestSeat::ROW_LIMIT_MAX).not_to be_nil
  end

  it 'has a CORRIDOR_PRIORITY constant' do
    expect(BestSeat::CORRIDOR_PRIORITY).not_to be_nil
  end

  it 'has a EXCEPTION_PRIORITY constant' do
    expect(BestSeat::EXCEPTION_PRIORITY).not_to be_nil
  end
end
