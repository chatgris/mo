# encoding: UTF-8
require_relative 'test_helper'

describe Mo::Runner do
  before do
    @mock = MiniTest::Mock.new
    @runner = Mo::Runner.new
  end

  describe '#which' do
    it 'should find ruby' do
      @runner.which('ruby').wont_be_nil
    end
  end

  describe '#encoding' do
    it 'should call sed no encoding' do
      Dir.chdir 'test/fixtures/encoding/without_encoding' do
        @mock.expect(:system, nil, ["sed -i -r '1 s/^(.*)$/# encoding: utf-8\\n\\1/g' ruby_without_encoding.rb"])
        @runner.encoding(@mock)
        @mock.verify
      end
    end

    it 'should not call sed on emacs encoding' do
      Dir.chdir 'test/fixtures/encoding/with_encoding' do
        @runner.encoding(@mock)
        @mock.verify
      end
    end
  end
end
