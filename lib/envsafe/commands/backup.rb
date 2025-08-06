require "fileutils"
require "json"
require_relative "../constants"

module Envsafe::Commands; end

class Envsafe::Commands::Backup
  class << self
    def run(tag: nil)
      tag = nil if tag == "tag" # Set it to nil and ignore "tag" string as an invalid tag.

      unless File.exist?(Envsafe::ENV_FILE)
        puts "❌ No .env file found in current directory."
        return
      end

      FileUtils.mkdir_p(Envsafe::BACKUP_DIR)

      unless File.exist?(Envsafe::MAIN_ENV)
        FileUtils.cp(Envsafe::ENV_FILE, Envsafe::MAIN_ENV)
      end

      timestamp = Time.now.utc.to_i
      filename = tag ? "#{timestamp}_#{tag}.env" : "#{timestamp}.env"
      dest_path = File.join(Envsafe::BACKUP_DIR, filename)

      FileUtils.cp(Envsafe::ENV_FILE, dest_path)

      puts "✅ Backed up .env as #{filename}"

      update_stack(filename, timestamp, tag)
    end

    private

    def update_stack(filename, timestamp, tag)
      stack = []

      if File.exist?(Envsafe::STACK_FILE)
        content = File.read(Envsafe::STACK_FILE)
        stack = JSON.parse(content)
      end

      entry = {
        "file" => filename,
        "tag" => tag,
        "timestamp" => timestamp
      }

      stack.unshift(entry)

      File.write(Envsafe::STACK_FILE, JSON.pretty_generate(stack))
    end
  end
end
