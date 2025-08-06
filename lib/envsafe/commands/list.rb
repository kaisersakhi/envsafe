require "terminal-table"
require_relative "../constants"

module Envsafe::Commands; end

class Envsafe::Commands::List
  class << self
    def run(limit = 10)

      limit = limit.nil? ? limit : limit.to_i

      if !limit.nil? && (limit.zero? || limit < 0)
        puts "❌ Limit must be an Integer and greater than zero."
        puts()
        puts "Example: envsafe list 5"
        puts "Default limit is 10"
        return
      end

      unless File.exist?(Envsafe::STACK_FILE)
        puts "❌ There is nothing to show or the main .envstack/stack.json is missing."

        return
      end

      IO.popen("less", "w") { |io| io.write(read_lines(limit))}
    end

    private

    def read_lines(n)
      stk_content = File.read(Envsafe::STACK_FILE)
      stack = JSON.parse(stk_content)

      n = n.nil? ? stack.length : n
      n = stack.size if n > stack.size

      stack = stack[0, n]

      rows = stack.map { |item| [File.join(Envsafe::BACKUP_DIR, item["file"]), item["tag"], item["timestamp"], Time.at(item["timestamp"])] }

      Terminal::Table.new(headings: ["File", "Tag", "Timestamp", "Backed up at"], rows: rows)
    end
  end
end
