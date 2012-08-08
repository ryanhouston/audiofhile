module Audiofhile
  class Configuration
    CONFIG_FILE = File.join(Dir.home, '.audiofhile').freeze

    def initialize
      load_config
    end

    def self.config_file
      CONFIG_FILE
    end

    def load_config
      if File.exists? CONFIG_FILE
        @config = YAML::load_file(CONFIG_FILE)
      else
        @config = options
      end
    end

    def collection_path=(dir)
      @collection_path = dir
    end

    def collection_path
      @collection_path ||= @config['audiofhile']['collection']['path'] unless @config.nil?
    end

    def write
      yield(self)
      File.open(CONFIG_FILE, 'w+') {|f| f.write(options.to_yaml) }
    end

    def options
      options = {
        "audiofhile" => {
          "collection" => {
            "path" => collection_path
          }
        }
      }

      options
    end

  end
end

