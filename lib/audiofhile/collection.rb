require 'audiofhile/helpers'
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
      finder.audio_files(extension)
    end

    def finder
      @finder ||= FileFinder.new(@path)
    end

    def artists
      extract_artists.uniq.compact.sort
    end

    def extract_artists
      artist_list = mute_stderr do
        audio_files.collect do |file|
          TagLib::FileRef.open(file) { |fileref| fileref.tag.artist }
        end
      end
    end

    def crufty_dirs
      finder.directories_without_audio_files
    end

  end
end

