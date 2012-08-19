module Audiofhile
  class InvalidAudioFormatError < StandardError; end;

  class FileFinder
    AUDIO_FORMATS = %w(mp3 m4a m4p mpa aif mid wav wma flac ogg).freeze
    MATCH_ALL_FORMATS = "*.{" + AUDIO_FORMATS.join(",") + "}".freeze

    def initialize (base_path)
      @base_path = base_path
    end

    def audio_files (extension = :all)
      audio_files_in_dir(@base_path, extension)
    end

    def audio_files_in_dir (dir, extension = :all)
      raise ArgumentError, "Must supply a directory to search" if dir.nil?

      search_pattern = File.join(dir, "**", file_pattern(extension))
      files = Dir.glob search_pattern
    end

    def file_pattern (extension = :all)
      (extension == :all) ? MATCH_ALL_FORMATS : file_pattern_match(extension)
    end

    def file_pattern_match (extension)
      unless is_valid_extension extension
       raise InvalidAudioFormatError, extension.to_s + " is not known audio format"
      end

      "*." + extension.to_s
    end

    def is_valid_extension (extension)
      AUDIO_FORMATS.include? extension.to_s.gsub(/^\./, '')
    end

    def directories_without_audio_files
      all_directories.reject do |dir|
        audio_files_in_dir(dir).count > 0
      end
    end

    def all_directories
      Dir.glob(File.join(@base_path, '**/'))
    end

    def all_files
      Dir.glob(File.join(@base_path, '**/*'))
    end

    def non_audio_files
      all_files.reject do |file|
        FileTest.directory?(file) || is_valid_extension(File.extname(file))
      end
    end

  end
end

