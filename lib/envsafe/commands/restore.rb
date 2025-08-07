require_relative "../back_stack"
require_relative "../utils"

module Envsafe::Commands; end

class Envsafe::Commands::Restore
  class << self
    def run(tag:, sindex:)
      back_stack = Envsafe::BackStack.stack()
      parsed_sindex = Envsafe::Utils.parse_int(sindex)

      if sindex && (parsed_sindex.nil? || parsed_sindex < 0 || parsed_sindex >= back_stack.size)
        puts "❌ Invalid sindex provided or out of range."

        return
      end

      if tag && not Envsafe::Utils.tag_present?(tag, back_stack)
        puts "❌ Tag not found in the backup stack. Check with 'envsafe list'"

        return
      end

      if tag.nil? && sindex.nil?
        puts "ℹ️ Tag or sindex is not provided restoring the last backed version."
      end

      has_restored = if tag
        Envsafe::BackStack.restore_by_tag(tag)
      elsif sindex
        Envsafe::BackStack.restore_by_sindex(parsed_sindex)
      else
        Envsafe::BackStack.restore_top
      end

      if has_restored
        puts "✅ Restored successfully."
      else
        puts "❌ Failed to restore."
      end
    end
  end
end
