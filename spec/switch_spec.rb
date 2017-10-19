require 'spec_helper'

describe 'db-switch' do
  before(:each) do
    expect(User.count).to eq(0)
    ActiveRecord::Base.connect_to(:alternate) do
      expect(User.count).to eq(0)
    end
  end

  it 'should create records in primary db' do
    expect(User.create!(name: 'Nick')).to be_truthy
    expect(User.count).to eq(1)

    ActiveRecord::Base.connect_to(:alternate) do
      expect(User.count).to eq(0)
    end
  end

  it 'should create records in alternate db' do
    ActiveRecord::Base.connect_to(:alternate) do
      expect(User.create!(name: 'Sergey')).to be_truthy
      expect(User.count).to eq(1)
    end

    expect(User.count).to eq(0)
  end

  it 'should query against proper db' do
    ActiveRecord::Base.connect_to(:alternate) do
      expect(User.create!(name: 'Nick', age: 33)).to be_truthy
      expect(User.count).to eq(1)
    end

    expect(User.create!(name: 'Nick', age: 32)).to be_truthy
    expect(User.count).to eq(1)
    expect(User.last.name).to eq('Nick')
    expect(User.last.age).to eq(32)

    ActiveRecord::Base.connect_to(:alternate) do
      expect(User.count).to eq(1)
      expect(User.last.name).to eq('Nick')
      expect(User.last.age).to eq(33)
    end
  end

  it 'should operate thread safely' do
    (1..20).map do |i|
      Thread.new do
        sleep 0.5

        if i.odd?
          ActiveRecord::Base.connect_to(:alternate) { User.create!(name: 'Nick') }
        else
          User.create!(name: 'Sergey')
        end
      end
    end.map(&:join)

    expect(User.count).to eq(10)
    expect(User.where(name: 'Sergey').count).to eq(10)

    ActiveRecord::Base.connect_to(:alternate) do
      expect(User.count).to eq(10)
      expect(User.where(name: 'Nick').count).to eq(10)
    end
  end
end
