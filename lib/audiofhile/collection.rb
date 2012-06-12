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

    def audio_files
      finder = FileFinder.new(@path)
      finder.audio_files
    end
  end

end
