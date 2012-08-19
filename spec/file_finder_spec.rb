require 'spec_helper'
require 'audiofhile/file_finder'

module Audiofhile
  describe FileFinder do
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

    it "should provide a list of directories NOT containing any audio files" do
      subject.directories_without_audio_files.should_not be_nil
    end
  end
end

