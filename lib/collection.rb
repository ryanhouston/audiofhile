module TunesTools
  class InvalidCollectionError < StandardError; end;

  class Collection
    attr_reader :path

    def initialize(path)
      @path = path
      raise InvalidCollectionError if not File.directory? @path
    end

    def file_types
    end
  end

end
