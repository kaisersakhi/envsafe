require_relative "constants"
require_relative "file_store"

"""

stack_entry = {
  :file
  :tag
  :timestamp
}

"""

class Envsafe::BackStack
  class << self
    def stack
      stack_instance
    end

    # Restores last backuped up file
    def pop()
      if stack_instance.nil? || stack_instance.size.zero?
        puts "There are no backups to restore."

        return
      end

      entry = stack_instance.shift

      if Envsafe::FileStore.restore(entry)
        write()
        puts "✅ Successfully retored the last backup"

      else
        stack_instance.unshift(entry)

        puts "❌ Something went wrong will retoring the last backup."
      end
    end

    def push(tag)
      unless File.exist?(Envsafe::ENV_FILE)
        puts "❌ No .env file found in current directory."
        return
      end


      filename, timestamp = Envsafe::FileStore.new_filename(tag)

      Envsafe::FileStore.copy_env(filename)

      push_entry(filename, tag, timestamp)

      puts "✅ Backed up .env as #{filename}"
    end

    def restore_by_tag(tag)
      entry = stack_instance.find { |e| e["tag"] == tag }

      return nil if entry.nil?

      Envsafe::FileStore.restore(entry)

      true
    end

    def restore_by_sindex(sindex)
      entry = stack_instance[sindex]

      Envsafe::FileStore.restore(entry)

      true
    end

    def restore_top
      return nil if stack_instance.empty?

      entry = stack_instance[0]

      Envsafe::FileStore.restore(entry)

      true
    end

    def show_top()
      return if stack_instance.empty?

      stack_entry = stack_instance[0]

      file_content = Envsafe::FileStore.file_content(stack_entry)

      Envsafe::Utils.print_with_less(file_content)
    end

    def show_by_tag(tag)
      stack_entry = stack_instance.find { |se| se["tag"] == tag }

      file_content = Envsafe::FileStore.file_content(stack_entry)

      Envsafe::Utils.print_with_less(file_content)
    end

    def show_by_sindex(sindex)
      stack_entry = stack_instance[sindex]

      file_content = Envsafe::FileStore.file_content(stack_entry)

      Envsafe::Utils.print_with_less(file_content)
    end

    private

    def push_entry(filename, tag, timestamp)
      entry = {
        "file" => filename,
        "tag" => tag,
        "timestamp" => timestamp
      }

      stack_instance.unshift(entry)

      write()
    end

    def stack_instance
      @stack_instance ||= read() || []
    end

    def read
      return unless File.exist?(Envsafe::STACK_FILE)

      stk_content = File.read(Envsafe::STACK_FILE)

      JSON.parse(stk_content)
    end

    # Writes stack_instace to stack.json
    def write
      File.write(Envsafe::STACK_FILE, JSON.pretty_generate(stack_instance))
    end
  end
end
