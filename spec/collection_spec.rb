require 'spec_helper'
require 'collection'

module Audiofhile
  describe Collection do

    context "with a valid path" do
      before { @path = File.expand_path("../", __FILE__) }

      subject { Collection.new(@path) }

      its(:path) { should eq @path }

      it "produces a list of audio file types in the collection" do
        should respond_to :file_types
      end

      its(:audio_files) do
        should_not be_nil
      end

      it "should have music files" do
        collection = Collection.new('/home/rhouston/Music')
        puts collection.audio_files.join("\n")
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
