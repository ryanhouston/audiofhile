require 'taglib'

module Audiofhile
  class InvalidCollectionError < StandardError; end;

  class Collection
    include Helpers
    attr_reader :path

    def initialize(path)
      @path = path
      raise InvalidCollectionError unless File.directory? @path
    end

    def formats
      audio_files.collect { |file| File.extname(file) }.uniq
    end

    def audio_files(extension = :all)
      finder = FileFinder.new(@path)
      finder.audio_files(extension)
    end

    def artists
      artist_list = mute_stderr do
        audio_files.collect do |file|
          TagLib::FileRef.open(file) { |fileref| fileref.tag.artist }
        end
      end

      artist_list.uniq.compact!.sort
    end
  end

end
