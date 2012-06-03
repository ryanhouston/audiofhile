module TunesTools
  class InvalidCollectionError < StandardError; end;

  class Collection
    def directory
      @directory ||= Dir.new(path)
      raise InvalidCollectionError if not File.directory?(@directory.path)

      @directory
    end

    def path
      '/media/DATA__/Music/sync'
    end
  end
end
