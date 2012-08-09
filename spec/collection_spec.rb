require 'spec_helper'
require 'audiofhile/collection'

module Audiofhile
  describe Collection do

    context "with a valid path" do
      before { @path = File.expand_path("../", __FILE__) }

      subject { Collection.new(@path) }

      its(:path) { should eq @path }

      it "produces a list of audio file types in the collection" do
        should respond_to :formats
      end

      its(:audio_files) do
        should_not be_nil
      end

      it "should return a unique list of artists in the collection" do
        subject.stub(:extract_artists) do
          ['Zion Lion', 'My Morning Jacket', nil, 'Dr. Dog', 'Frank Zappa', 'Dr. Dog']
        end
        expected = ['Dr. Dog', 'Frank Zappa', 'My Morning Jacket', 'Zion Lion']
        subject.artists.should eq expected
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
