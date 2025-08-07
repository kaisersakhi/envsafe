require "fileutils"
require "json"

require_relative "../utils"
require_relative "../constants"
require_relative "../back_stack"

module Envsafe::Commands; end

class Envsafe::Commands::Backup
  class << self
    def run(tag: nil)
      tag = nil if tag == "tag" # Set it to nil and ignore "tag" string as an invalid tag.

      if tag && Envsafe::Utils.invalid_tag?(tag)
        puts "❌ Invalid tag...."
        puts "Use alphanumeric or pure numbers"
        puts "Special symbols are invalid except: hyphen and underscore"

        return
      end

      if tag && Envsafe::Utils.tag_present?(tag, Envsafe::BackStack.stack)
        puts "❌ Tag already exists in the stack. Please use a different tag."

        return
      end


      Envsafe::BackStack.push(tag)
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
