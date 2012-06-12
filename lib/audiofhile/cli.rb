require "thor"

module Audiofhile
  class CLI < Thor

    class_option "path", :type => "string", :required => true, :banner => "The path to the audio collection"

    def initialize(*)
      super
      @collection = Collection.new(options['path'])
    end

    desc "files", "List all files in the audio collection"
    def files
      puts @collection.audio_files
    end

    desc "formats", "List all audio file formats in the audio collection"
    def formats
      puts @collection.formats
    end

  end
end

