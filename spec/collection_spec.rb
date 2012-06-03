require 'spec_helper'
require 'collection'

module TunesTools
  describe Collection do
    subject { Collection.new(File.expand_path("../", __FILE__)) }

    it "can be given a path to the collection" do
      path = File.expand_path('../../', __FILE__)
      collection = Collection.new path

      collection.path.should eq path
    end

    it "raises an error if the given directory does not exist" do
      expect do
        collection = Collection.new("/path/does/not/exist")
      end.to raise_error(InvalidCollectionError)
    end

  end
end
