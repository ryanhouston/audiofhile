require 'find'

module Audiofhile
  class InvalidAudioFormatError < StandardError; end;

  class FileFinder
    AUDIO_FORMATS = %w(mp3 m4a m4p mpa aif mid wav wma flac ogg).freeze
    MATCH_ALL_FORMATS = "*.{" + AUDIO_FORMATS.join(",") + "}".freeze

    def initialize (base_path)
      @base_path = base_path
    end

    def audio_files (extension = :all)
      search_pattern = File.join(@base_path, "**", file_pattern(extension))
      files = Dir.glob search_pattern
    end

    def file_pattern (extension = :all)
      extension == :all ? MATCH_ALL_FORMATS : file_pattern_match(extension)
    end

    def file_pattern_match (extension)
      unless is_valid_extension extension
       raise InvalidAudioFormatError, extension.to_s + " is not known audio format"
      end

      "*." + extension.to_s
    end

    def is_valid_extension (extension)
      AUDIO_FORMATS.include? extension.to_s
    end

    def directories_without_audio_files
      directories = []
      Find.find(@base_path) do |path|
        if FileTest.directory?(path)
          directories << path unless directories.include? path
        elsif is_valid_extension(File.extname(path))
          directories.delete(File.dirname(path))
        end
      end

      directories
    end

  end
end

