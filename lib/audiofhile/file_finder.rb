module Audiofhile
  class FileFinder
    AUDIO_FORMATS = %w(mp3 m4a m4p mpa aif mid wav wma flac ogg).freeze

    def initialize (base_path)
      @base_path = base_path
    end

    def audio_files
      search_pattern = File.join(@base_path, "**", "*.{" + audio_extensions.join(",") +"}" )
      files = Dir.glob search_pattern
    end

    def audio_extensions
      AUDIO_FORMATS
    end
  end
end

