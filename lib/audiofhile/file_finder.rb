module Audiofhile
  class InvalidAudioFormatError < StandardError; end;

  class FileFinder
    AUDIO_FORMATS = %w(mp3 m4a m4p mpa aif mid wav wma flac ogg).freeze
    MATCH_ALL_FORMATS = "*.{" + AUDIO_FORMATS.join(",") + "}".freeze

    def initialize (base_path)
      @base_path = base_path
    end

    def audio_files (extension = nil)
      file_pattern   = extension.nil? ? MATCH_ALL_FORMATS : file_pattern_match(extension)
      search_pattern = File.join(@base_path, "**", file_pattern)
      files = Dir.glob search_pattern
    end

    def file_pattern_match (extension)
      extension.gsub!('.', '')

      unless AUDIO_FORMATS.include? extension
        raise InvalidAudioFormatError, extension + " is not known audio format"
      end

      "*." + extension
    end
  end
end

