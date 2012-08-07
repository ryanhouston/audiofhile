require 'spec_helper'
require 'audiofhile/configuration'

module Audiofhile
  describe Configuration do

    context "With fresh instance" do
      subject { Configuration.new }

      after (:all) do
        File.delete Configuration.config_file
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

