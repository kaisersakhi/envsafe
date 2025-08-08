require_relative "../constants"

module Envsafe::Commands; end

class Envsafe::Commands::Undo
  class << self
    def run()
      puts "Undoing the last write operation...."

      if File.exist?(Envsafe::MAIN_ENV)
        FileUtils.cp(Envsafe::MAIN_ENV, Envsafe::ENV_FILE)

        puts "✅ Undo was successful"
      else
        puts "❌ Undo failed, have you backed up your .env?"
      end
    end
  end
end
