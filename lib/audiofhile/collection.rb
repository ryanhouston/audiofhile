module Audiofhile
  class InvalidCollectionError < StandardError; end;

  class Collection
    attr_reader :path

    def initialize(path)
      @path = path
      raise InvalidCollectionError unless File.directory? @path
    end

    def formats
      formats = []
      audio_files.each do |file|
        ext = File.extname(file)
        formats << ext unless formats.include?(ext)
      end

      formats
    end

    def audio_files
      finder = FileFinder.new(@path)
      finder.audio_files
    end
  end

end
