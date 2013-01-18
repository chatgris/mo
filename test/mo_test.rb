# encoding: UTF-8
require 'mo'
require 'minitest/autorun'

describe Mo::Runner do
  before do
    @runner = Mo::Runner.new
  end

  it 'should find ruby' do
    @runner.which('ruby').wont_be_nil
  end
end
