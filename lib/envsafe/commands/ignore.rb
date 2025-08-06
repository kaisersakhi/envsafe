module Envsafe::Commands; end

class Envsafe::Commands::Ignore
  class << self
    IGNORE_FILE = ".gitignore"
    def run
      unless File.exist?(IGNORE_FILE) && File.readable?(IGNORE_FILE) && File.writable?(IGNORE_FILE)
        puts "❌ Couldn't load .gitignore or either the file can't be read or written."
        return
      end

      File.foreach(IGNORE_FILE) do |line|
        if line.strip() == ".envsafe"
          puts "✅ .envsafe is already ignored."

          return
        end
      end

      File.open(IGNORE_FILE, "a") do |file|
        file.puts(".envsafe")
        puts "✅ .envsafe has been ignored."
      end
    end
  end
end
