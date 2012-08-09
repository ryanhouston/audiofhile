require 'taglib'

module Audiofhile
  class InvalidCollectionError < StandardError; end;

  class Collection
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
      $stderr.reopen('/dev/null', 'w')
      artist_list = audio_files.collect do |file|
        TagLib::FileRef.open(file) do |fileref|
          fileref.tag.artist
        end
      end
      $stderr = STDERR

      artist_list.uniq
    end
  end

end
