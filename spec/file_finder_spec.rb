require 'spec_helper'
require 'audiofhile/file_finder'
require 'fakefs/spec_helpers'

module Audiofhile
  describe FileFinder do
    include FakeFS::SpecHelpers

    subject { FileFinder.new(File.expand_path('../', __FILE__)) }

    its(:audio_files) { should be_a(Array) }

    it "raises an error for unknown formats" do
      expect do
         subject.file_pattern_match(:doc)
      end.to raise_error(InvalidAudioFormatError)
    end

    it "builds a file search pattern to match extensions" do
      subject.file_pattern_match(:mp3).should eq('*.mp3')
    end

    it "responds whether or not a extension is valid" do
      expect { subject.is_valid_extension(:mp3).should be_true }
      expect { subject.is_valid_extension(:nope).should be_false }
    end

    context "provided a collection of directories containing mixed file types" do
      before(:each) do
        FakeFS.activate!
        prepare_test_collection
      end

      after(:each) do
        FakeFS.deactivate!
      end

      subject { FileFinder.new('/music') }

      def prepare_test_collection
        FileUtils.mkdir_p('/music/no_audio')
        FileUtils.mkdir_p('/music/a/aa')
        FileUtils.touch([
          '/music/a/aa/01 a.mp3',
          '/music/a/aa/aa.jpg',
          '/music/no_audio/nope.db'
        ])
      end

      it "should provide a list of directories NOT containing any audio files" do
        subject.directories_without_audio_files.should == ['/music/no_audio']
      end

      it "should provide a list of non-audio type files in the collection" do
        subject.non_audio_files.should == ['/music/a/aa/aa.jpg', '/music/no_audio/nope.db']
      end
    end

  end
end

