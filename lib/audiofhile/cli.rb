require "thor"
require "yaml"

module Audiofhile
  class CLI < Thor
    class_option "path", :type => "string", :required => false, :banner => "The path to the audio collection"

    def initialize(*)
      super
      load_path
    end

    desc "path [DIR]", "Show or set the path to be used in future operations"
    def path(dir = nil)
      if dir
        config.write do |c|
          c.collection_path = dir
        end
      else
        unless File.exists? Configuration.config_file
          raise RuntimeError, "No collection path has been set"
        end

        puts config.collection_path
      end
    end

    desc "files", "List all files in the audio collection"
    method_option "ext", :type => :string, :banner => "Only show files of the specified extension"
    def files
      if options[:ext]
        puts collection.audio_files_of_format(options[:ext].to_sym)
      else
        puts collection.audio_files
      end
    end

    desc "formats", "List all audio file formats in the audio collection"
    def formats
      puts @collection.formats
    end

    private
      def load_path
        @path ||= options['path'] || config.collection_path
      end

      def config
        @config ||= Configuration.new
      end

      def collection
        @collection ||= Collection.new(collection_path)
      end

      def collection_path
        unless @path
          raise RuntimeError, "Must supply --path option or set path using 'path' command"
        end

        @path
      end

  end
end

