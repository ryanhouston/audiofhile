require 'spec_helper'
require 'file_finder'

module Audiofhile
  describe FileFinder do
    subject { FileFinder.new(File.expand_path('../', __FILE__)) }

    its(:audio_extensions) { should be_a(Array) }
    its(:audio_files) { should be_a(Array) }
  end
end
