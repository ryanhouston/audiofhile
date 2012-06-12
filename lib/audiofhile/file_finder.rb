module Audiofhile
  class FileFinder
    def initialize (base_path)
      @base_path = base_path
    end

    def audio_files
      search_pattern = File.join(@base_path, "**", "*.{" + audio_extensions.join(",") +"}" )
      files = Dir.glob search_pattern
    end

    def audio_extensions
      ['mp3', 'm4a', 'm4p', 'mpa', 'aif', 'mid', 'wav', 'wma', 'flac', 'ogg']
    end
  end
end

