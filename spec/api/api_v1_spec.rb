require_relative "../spec_helper"
require "yaml"

describe Oss::Index do
  before(:all) do
    @name = "test_oss_rb"
    @index = Oss::Index.new(@name)
  end

  describe '#OssIndex(name)' do
    it "should not work with no index name" do
      # Oss::Index.new().should raise_error
    end
  end

  describe '#OssIndex' do
    it "fetches the OssIndex client object" do
      @index.should be_an_instance_of(Oss::Index)
    end
  end

  describe '#delete index' do
    it "delete index" do
      indexes = @index.delete!
      @index.list.include?@name.should == @name
    end
  end

  describe '#create index' do
    it "create index" do
      indexes = @index.create('EMPTY_INDEX')
      @index.list.include?@name.should == @name
    end
  end

  describe '#create index' do
    it "create index" do
      indexes = @index.create('EMPTY_INDEX')
      @index.list.include?@name.should == @name
    end
  end

  describe '#set fields' do
    it 'set fields' do
      @index.set_field(false, true, 'id', nil, true, true, nil)
      @index.set_field(true, false, 'user', 'StandardAnalyzer', true, true, nil)
    end
  end

  describe '#index docs' do
    it "create index, set fields, index docs" do
      (1..15).each do |i|
        doc = Oss::Document.new("en")
        doc.add_field('id', "#{i}")
        doc.add_field('user', "john#{i}")
        @index.add_document(doc)
      end
      @index.index!
      puts @index.search('j*', 'id')
      @index.search('j*', 'id').length.should == 10
    end
  end

  #  describe '#delete fields' do
  #    it 'set fields, delete fields' do
  #      @index.delete_field('id')
  #      @index.delete_field('user')
  #    end
  #  end
  #
  #  describe '#delete index' do
  #    it 'create index, delete index' do
  #      @index.delete!
  #    end
  #  end

end