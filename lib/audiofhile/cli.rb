require "thor"

module Audiofhile
  class CLI < Thor

    desc "files", "List all files in the audio collection"
    def files
      puts "This is the 'files' job"
    end

  end
end

