require "fileutils"

class Envsafe::FileStore
  class << self
    def copy_env(filename)
      FileUtils.mkdir_p(Envsafe::BACKUP_DIR)

      unless File.exist?(Envsafe::MAIN_ENV)
        backup_current_to_main_env()
      end

      dest_path = File.join(Envsafe::BACKUP_DIR, filename)

      FileUtils.cp(Envsafe::ENV_FILE, dest_path)
    end

    def delete_backup(stack_entry)
      File.delete(full_filepath(stack_entry))
    end


    def new_filename(tag)
      timestamp = Time.now.utc.to_i

      [(tag ? "#{timestamp}_#{tag}.env" : "#{timestamp}.env"), timestamp]
    end

    # Deletes the file after copying it to main.
    def restore_main(stack_entry)
      backup_current_to_main_env()

      FileUtils.cp(full_filepath(stack_entry), Envsafe::ENV_FILE)

      delete_backup(stack_entry)
    end

    def backup_current_to_main_env
       FileUtils.cp(Envsafe::ENV_FILE, Envsafe::MAIN_ENV)
    end

    # Overwrites .env with main.env
    def undo_last_restore
      FileUtils.cp(Envsafe::MAIN_ENV, Envsafe::ENV_FILE)
    end


    def filename(stack_entry)
      return if stack_entry.nil?

      file, tag, timestamp = dse

      tag ? "#{timestamp}_#{tag}.env" : "#{timestamp}.env"
    end

    def full_filepath(stack_entry)
      File.join(Envsafe::BACKUP_DIR, filename(stack_entry))
    end

    private

    # Destructured Stack Entry (dse)
    def dse(se)
      [se["file"], se["tag"], se["timestamp"]]
    end

  end
end
