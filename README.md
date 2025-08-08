# Envsafe

A Ruby CLI tool for safely managing and versioning your `.env` files. Envsafe provides backup, restore, and history management capabilities to prevent accidental loss of environment variables.

## Features

- 📁 **Backup Management**: Create tagged or automatic backups of your `.env` files
- 🔄 **Restore System**: Restore any previous backup by tag or index
- 📋 **History Tracking**: List all backups with timestamps and tags
- ⏪ **Undo Operations**: Quickly undo the last write operation
- 👀 **File Preview**: View contents of any backup without restoring
- 🗑️ **Selective Cleanup**: Delete specific backups or clear all history
- 🔒 **Git Integration**: Automatically add `.envsafe` to your `.gitignore`

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'envsafe'
```

And then execute:

```bash
$ bundle install
```

Or install it yourself as:

```bash
$ gem install envsafe
```

## Usage

### Basic Commands

#### Backup your .env file

```bash
# Create a backup with automatic timestamp
$ envsafe backup

# Create a tagged backup for easy identification
$ envsafe backup --tag "before-production-deploy"
$ envsafe backup -t "pre-feature-update"
```

#### List all backups

```bash
# Show all backups
$ envsafe list

# Limit the number of backups shown
$ envsafe list 5
```

#### Restore a backup

```bash
# Restore by tag
$ envsafe restore --tag "before-production-deploy"
$ envsafe restore -t "pre-feature-update"

# Restore by stack index (use 'list' command to see indices)
$ envsafe restore --sindex 0
$ envsafe restore -i 2
```

#### Quick undo

```bash
# Undo the last write operation to .env
$ envsafe undo
```

### Advanced Commands

#### View backup contents

```bash
# Show contents by tag
$ envsafe show --tag "production-config"
$ envsafe show -t "staging-setup"

# Show contents by stack index
$ envsafe show --sindex 0
$ envsafe show -i 1
```

#### Delete specific backups

```bash
# Delete by tag
$ envsafe delete --tag "old-config"
$ envsafe delete -t "temporary-backup"

# Delete by stack index
$ envsafe delete --sindex 3
$ envsafe delete -i 0
```

#### Cleanup operations

```bash
# Delete all backups
$ envsafe clear

# Add .envsafe directory to .gitignore
$ envsafe ignore
```

## Command Reference

| Command        | Description                                | Options                                                                           |
| -------------- | ------------------------------------------ | --------------------------------------------------------------------------------- |
| `backup`       | Create a backup of current `.env` file     | `-t, --tag TAG` - Optional tag for the backup                                     |
| `list [LIMIT]` | List all backups, optionally limit results | `LIMIT` - Number of backups to show                                               |
| `restore`      | Restore a specific backup to `.env`        | `-t, --tag TAG` - Restore by tag<br>`-i, --sindex INDEX` - Restore by stack index |
| `undo`         | Undo last write operation to `.env`        | None                                                                              |
| `show`         | Show contents of a backup file             | `-t, --tag TAG` - Show by tag<br>`-i, --sindex INDEX` - Show by stack index       |
| `delete`       | Delete a specific backup                   | `-t, --tag TAG` - Delete by tag<br>`-i, --sindex INDEX` - Delete by stack index   |
| `clear`        | Delete all backups                         | None                                                                              |
| `ignore`       | Add `.envsafe` to `.gitignore`             | None                                                                              |

## Workflow Examples

### Development Workflow

```bash
# Before making changes
$ envsafe backup -t "stable-config"

# Make your changes to .env
$ vim .env

# If something goes wrong, quickly undo
$ envsafe undo

# Or restore the tagged backup
$ envsafe restore -t "stable-config"
```

### Deployment Workflow

```bash
# Backup before deployment
$ envsafe backup -t "pre-deploy-$(date +%Y%m%d)"

# Deploy and update environment variables
# ... deployment process ...

# If rollback needed
$ envsafe restore -t "pre-deploy-20240108"
```

### Team Collaboration

```bash
# Setup git ignore for the team
$ envsafe ignore

# Create backups with descriptive tags
$ envsafe backup -t "feature-auth-setup"
$ envsafe backup -t "database-migration-config"

# Share backup strategies in documentation
$ envsafe list
```

## File Structure

Envsafe stores backups in a `.envsafe` directory in your project root:

```
your-project/
├── .env
├── .envsafe/
│   ├── backup-001.env
│   ├── backup-002.env
│   └── metadata.json
└── .gitignore
```

## Best Practices

1. **Tag Important Backups**: Use descriptive tags for backups before major changes
2. **Regular Cleanup**: Periodically review and clean old backups with `envsafe clear`
3. **Git Ignore**: Always run `envsafe ignore` to prevent committing backup files
4. **Pre-deployment**: Create tagged backups before deployments for easy rollback
5. **Team Coordination**: Establish tagging conventions for team projects

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/kaisersakhi/envsafe.

## License

The gem is available as open source under the terms of the MIT License.
