require_relative "../constants"
require_relative "../back_stack"
require_relative "../utils"

module Envsafe::Commands; end

class Envsafe::Commands::Show
  class << self
    def run(tag:, sindex:)
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

      if sindex
        Envsafe::BackStack.show_by_sindex(parsed_sindex)
      elsif tag
        Envsafe::BackStack.show_by_tag(tag)
      else
        Envsafe::BackStack.show_top()
      end
    end
  end
end
