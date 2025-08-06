require_relative '../constants'

module Envsafe::Commands; end

class Envsafe::Commands::Ignore
  class << self
    def run
      unless File.exist?(Envsafe::IGNORE_FILE) && File.readable?(Envsafe::IGNORE_FILE) && File.writable?(Envsafe::IGNORE_FILE)
        puts "❌ Couldn't load .gitignore or either the file can't be read or written."
        return
      end

      File.foreach(Envsafe::IGNORE_FILE) do |line|
        if line.strip() == ".envsafe"
          puts "✅ .envsafe is already ignored."

          return
        end
      end

      File.open(Envsafe::IGNORE_FILE, "a") do |file|
        file.puts(".envsafe")
        puts "✅ .envsafe has been ignored."
      end
    end
  end
end
