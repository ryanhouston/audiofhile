require 'spec_helper'
require 'audiofhile/configuration'
require 'fileutils'

module Audiofhile
  describe Configuration do

    context "With fresh instance" do
      subject { Configuration.new }

      before (:all) do
        if File.exists? Configuration.config_file
          FileUtils.mv Configuration.config_file, Configuration.config_file + '.bak'
        end
      end

      after (:all) do
        File.delete Configuration.config_file
        if File.exists? Configuration.config_file + '.bak'
          FileUtils.mv Configuration.config_file + '.bak', Configuration.config_file
        end
      end

      it "should put the config file in the current user's home dir" do
        Configuration.config_file.should eq File.join(Dir.home, '.audiofhile')
      end

      it "should handle an unset collection path" do
        subject.collection_path.should be_nil
      end

      it "should set the collection path" do
        subject.collection_path = '/home/audiofhile'
        subject.collection_path.should eq '/home/audiofhile'
      end

      it "should write a config file" do
        file_exists = File.exists? Configuration.config_file
        file_exists.should be_false

        subject.write do |c|
          c.collection_path = '/home/audiofhile'
        end

        file_exists = File.exists? Configuration.config_file
        file_exists.should be_true
      end
    end

  end
end

