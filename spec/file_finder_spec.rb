require 'spec_helper'
require 'audiofhile/file_finder'

module Audiofhile
  describe FileFinder do
    subject { FileFinder.new(File.expand_path('../', __FILE__)) }

    its(:audio_files) { should be_a(Array) }

    it "Raises an error for unknown formats" do
      expect { subject.file_pattern_match(:doc) }.to raise_error(InvalidAudioFormatError)
    end
  end
end

