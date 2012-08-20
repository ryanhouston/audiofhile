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

    context "provided a collection of directories containing mixed file types" do
      before(:each) do
        subject.stub(:all_files) { all_mock_files }
        subject.stub(:all_directories) { all_mock_directories }
        FileTest.stub(:directory?) { |file| mock_files[file][:is_directory] }
        File.stub(:extname) { |file| mock_files[file][:extname] }
      end

      it "should provide a list of directories NOT containing any audio files" do
        subject.stub(:audio_files_in_dir) { |dir| mock_files[dir][:audio_files] }
        subject.directories_without_audio_files.should == ['/music/no_audio']
      end

      it "should provide a list of non-audio type files in the collection" do
        subject.non_audio_files.should == ['/music/a/aa/aa.jpg', '/music/no_audio/nope.db']
      end
    end

    def all_mock_files
      mock_files.keys
    end

    def all_mock_directories
      mock_files.select { |file| mock_files[file][:is_directory] }.keys
    end

    def mock_files
      @mock_fs ||= {
        '/music/a'             => { :is_directory => true,  :extname => nil,
                                    :audio_files => ['/music/a/aa/01 a.mp3'] },
        '/music/a/aa'          => { :is_directory => true,  :extname => nil,
                                    :audio_files => ['/music/a/aa/01 a.mp3'] },
        '/music/a/aa/01 a.mp3' => { :is_directory => false, :extname => '.mp3' },
        '/music/a/aa/aa.jpg'   => { :is_directory => false, :extname => '.jpg' },
        '/music/no_audio'      => { :is_directory => true,  :extname => nil, :audio_files => [] },
        '/music/no_audio/nope.db' => { :is_directory => false, :extname => '.db' },
      }
    end
  end
end

