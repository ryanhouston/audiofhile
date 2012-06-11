module Audiofhile
  class InvalidCollectionError < StandardError; end;

  class Collection
    attr_reader :path

    def initialize(path)
      @path = path
      raise InvalidCollectionError unless File.directory? @path
    end

    def file_types
    end

    def audio_files
      finder = FileFinder.new(@path)
      finder.audio_files
    end
  end

end
