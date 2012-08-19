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

    it "should provide a list of non-audio type files in the collection" do
      subject.stub(:all_files) { all_files_list }
      FileTest.stub(:directory?) { |file| mock_files[file][:is_directory] }
      File.stub(:extname) { |file| mock_files[file][:extname] }

      subject.non_audio_files.should == ['/music/a/aa/aa.jpg']
    end

    def all_files_list
      mock_files.keys
    end

    def mock_files
      @mock_fs ||= {
        '/music/a'             => { :is_directory => true, :extname => nil },
        '/music/a/aa'          => { :is_directory => true, :extname => nil },
        '/music/a/aa/01 a.mp3' => { :is_directory => false, :extname => '.mp3' },
        '/music/a/aa/aa.jpg'   => { :is_directory => false, :extname => '.jpg' },
      }
    end
  end
end

