require 'spec_helper'
require 'collection'

module TunesTools
  describe Collection do

    context "with a valid path" do
      before { @path = File.expand_path("../", __FILE__) }

      subject { Collection.new(@path) }

      its(:path) { should eq @path }

      it "produces a list of audio file types in the collection" do
        should respond_to :file_types
      end

    end

    context "with an invalid path" do
      it "raises an error if the given directory does not exist" do
        expect do
          collection = Collection.new("/path/does/not/exist")
        end.to raise_error(InvalidCollectionError)
      end
    end

  end
end
