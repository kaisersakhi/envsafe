require_relative "../back_stack"
require_relative "../utils"

module Envsafe::Commands; end

class Envsafe::Commands::Delete
  class << self
    def run(tag:, sindex:)
      if tag.nil? && sindex.nil?
        puts "❌ Please provide either a tag or an index."
        return
      end


      back_stack = Envsafe::BackStack.stack()
      parsed_sindex = Envsafe::Utils.parse_int(sindex)

      if back_stack.empty?
        puts "❌ No backup found. Please create one with 'backup' command."
        return
      end

      if tag && not Envsafe::Utils.tag_present?(tag, back_stack)
        puts "❌ Tag not found. Please check with 'list' command."
        return
      end

      if sindex && (parsed_sindex < 0 || parsed_sindex >= back_stack.size)
        puts "❌ Invalid index. Please check with 'list' command."
        return
      end


      if (Envsafe::BackStack.remove_by_sindex(parsed_sindex) if sindex) ||
      (Envsafe::BackStack.remove_by_tag(tag) if tag )
        puts "✅ Backup deleted successfully."
      end
    end
  end
end
