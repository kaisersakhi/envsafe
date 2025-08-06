require "thor"
require_relative "commands/backup"
require_relative "commands/ignore"
require_relative "commands/list"

module Envsafe
  class CLI < Thor
    desc("backup", "Backup current .env")
    option(:tag, aliases: "-t", type: :string, desc: "Optional tag for the backup")
    def backup
      Envsafe::Commands::Backup.run(tag: options[:tag])
    end

    desc("ignore", "Add .envsafe to git ignore")
    def ignore
      Envsafe::Commands::Ignore.run()
    end

    desc("list [LIMIT]", "List all backups, optionally limit the number shown")
    def list(limit = nil)
      Envsafe::Commands::List.run(limit)
    end
  end
end

# backup [--tag TAG]        "backup current .env with optional tag"
# list     n                "list all save .env version"
# checkout version/tag      "restore a specific backup to .env"
# checkout main             "restore the orgianl .env saved before the first backup"
# pop                       "restore and delete the latest backup (like git stash pop)"
# current                   "show which back is currenly checked out if any"
# delete  version/tag       "delete a specific backup version"
# clear                     "clear all backups"
# check                     "compare .env with .example.env"
# sync                      "sync .example with .env creates if doesn't exist"
# diff  version/tag         "show diff with the currrent and provided version or tag"
#
