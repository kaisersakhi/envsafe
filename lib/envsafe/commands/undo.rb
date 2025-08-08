require_relative "../constants"

module Envsafe::Commands; end

class Envsafe::Commands::Undo
  class << self
    def run()
      # check if main.env is tthere
      # if so then cp it to .env

      puts "Undoing the last write operation...."

      if File.exist?(Envsafe::MAIN_ENV)
        FileUtils.cp(Envsafe::MAIN_ENV, Envsafe::ENV_FILE)

        puts "✅ Undo was successful"
      end
    end
  end
end
