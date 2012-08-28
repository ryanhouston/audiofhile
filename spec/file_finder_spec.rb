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

      def prepare_test_collection
        FileUtils.mkdir_p('/music/no_audio')
        FileUtils.mkdir_p('/music/a/aa')
        FileUtils.mkdir_p('/music/special characters')
        FileUtils.mkdir_p('/music/special characters[1]')
        FileUtils.touch([
          '/music/a/aa/01 a.mp3',
          '/music/a/aa/aa.jpg',
          '/music/a/not_audio_in_artist_dir.ini',
          '/music/no_audio/nope.db',
          '/music/special characters/01 first. song.mp3',
          '/music/special characters/folder.jpg',
          '/music/special characters/folder[0].jpg',
          '/music/special characters[1]/folder.jpg'
        ])
      end

      subject { FileFinder.new('/music') }

      its (:directories_without_audio_files) { should eq ['/music/no_audio'] }

      its (:non_audio_files) { should eq expected_non_audio_files }

      def expected_non_audio_files
        [
          '/music/a/aa/aa.jpg',
          '/music/a/not_audio_in_artist_dir.ini',
          '/music/no_audio/nope.db',
          '/music/special characters/folder.jpg',
          '/music/special characters/folder[0].jpg',
          '/music/special characters[1]/folder.jpg'
        ]
      end
    end

  end
end

