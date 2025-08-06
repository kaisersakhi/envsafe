module Envsafe
  ENVSAFE_DIR = ".envsafe"
  BACKUP_DIR = File.join(ENVSAFE_DIR, "backups")
  MAIN_ENV = File.join(ENVSAFE_DIR, "main.env")
  STACK_FILE = File.join(ENVSAFE_DIR, "stack.json")
  ENV_FILE = ".env"
  ENV_EXAMPLE = ".example.env"
  IGNORE_FILE = ".gitignore"
end
