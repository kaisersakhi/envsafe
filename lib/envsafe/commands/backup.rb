require "fileutils"
require "json"

module Envsafe::Commands; end

class Envsafe::Commands::Backup
  class << self
    ENVSAFE_DIR = ".envsafe"
    BACKUP_DIR = File.join(ENVSAFE_DIR, "backups")
    MAIN_ENV = File.join(ENVSAFE_DIR, "main.env")
    STACK_FILE = File.join(ENVSAFE_DIR, "stack.json")
    ENV_FILE = ".env"
    ENV_EXAMPLE = ".example.env"

    def run(tag: nil)
      tag = nil if tag == "tag" # Set it to nil and ignore "tag" string as an invalid tag.

      unless File.exist?(ENV_FILE)
        puts "❌ No .env file found in current directory."
        return
      end

      FileUtils.mkdir_p(BACKUP_DIR)

      unless File.exist?(MAIN_ENV)
        FileUtils.cp(ENV_FILE, MAIN_ENV)
      end

      timestamp = Time.now.utc.to_i
      filename = tag ? "#{timestamp}_#{tag}.env" : "#{timestamp}.env"
      dest_path = File.join(BACKUP_DIR, filename)

      FileUtils.cp(ENV_FILE, dest_path)

      puts "✅ Backed up .env as #{filename}"

      update_stack(filename, timestamp, tag)
    end

    private

    def update_stack(filename, timestamp, tag)
      stack = []

      if File.exist?(STACK_FILE)
        content = File.read(STACK_FILE)
        stack = JSON.parse(content)
      end

      entry = {
        "file" => filename,
        "tag" => tag,
        "timestamp" => timestamp
      }

      stack.unshift(entry)

      File.write(STACK_FILE, JSON.pretty_generate(stack))
    end
  end
end
