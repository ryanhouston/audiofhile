module TunesTools
  class InvalidCollectionError < StandardError; end;

  class Collection
    attr_reader :path

    def initialize(path)
      @path = path
      raise InvalidCollectionError unless File.directory? @path
    end

    def file_types
    end
  end

end
