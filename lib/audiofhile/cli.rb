require "thor"
require "yaml"

module Audiofhile
  class CLI < Thor

    def initialize(*)
      super
      load_path
    end

    class_option "path", :type => "string", :required => false,
      :banner => "The path to the audio collection"

    desc "files", "List all files in the audio collection"
    method_option "ext", :type => :string,
      :banner => "Only show files of the specified extension"
    def files
      ext = options[:ext] ? options[:ext].to_sym : :all
      puts collection.audio_files(ext)
    end

    desc "formats", "List all audio file formats in the audio collection"
    def formats
      puts collection.formats
    end

    desc "path [DIR]", "Show or set the path to be used in future operations"
    def path(dir = nil)
      if dir
        config.write {|c| c.collection_path = dir }
      else
        puts config.collection_path || "No path has been set."
      end
    end

    desc "artists", "List the artists contained in the collection"
    def artists
      puts collection.artists
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

