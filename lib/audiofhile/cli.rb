require "thor"
require "yaml"

module Audiofhile
  class CLI < Thor
    CONFIG_FILE = File.join(File.dirname(__FILE__), '..', '..', '.audiofhile').freeze

    class_option "path", :type => "string", :required => true, :banner => "The path to the audio collection"

    def initialize(*)
      super
      @collection = Collection.new(options['path'])
    end

    desc "path [DIR]", "Show or set the path to be used in future operations"
    def path(dir = nil)
      if dir
        options = {"audiofhile" => {"collection" => {"path" => dir } } }
        File.open(CONFIG_FILE, 'w+') {|f| f.write(options.to_yaml) }
      else
        unless File.exists? CONFIG_FILE
          raise RuntimeError, "No collection path has been set"
        end

        config = YAML::load(CONFIG_FILE)
        puts config['audiofhile']['collection']['path']
      end
    end

    desc "files", "List all files in the audio collection"
    method_option "ext", :type => :string, :banner => "Only show files of the specified extension"
    def files
      if options[:ext]
        puts @collection.audio_files_of_format(options[:ext].to_sym)
      else
        puts @collection.audio_files
      end
    end

    desc "formats", "List all audio file formats in the audio collection"
    def formats
      puts @collection.formats
    end

  end
end

