# encoding: UTF-8
require_relative 'test_helper'

describe Mo::Runner do
  before do
    @runner = Mo::Runner.new
  end

  it 'should find ruby' do
    @runner.which('ruby').wont_be_nil
  end
end
