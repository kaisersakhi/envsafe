module Envsafe::Commands; end

class Envsafe::Commands::Clear
  class << self
    def run
      return unless user_sure?

      if system("rm", "-rf", ".envsafe")
        puts "✅ .envsafe removed successfully!"
      else
        puts "❌ Something went wrong...."
      end
    end

    private

    def user_sure?

      while true
        STDOUT.write "This action will delete .envsafe folder along will all versions of .env, are you sure? (yes/no): "
        STDOUT.flush

        response = STDIN.gets.chomp.downcase

        next if response.nil?

        if response == "yes"
          return true
        elsif response == "no"
          return false
        else
          puts "Please type yes/no"
        end
      end
    end
  end
end
