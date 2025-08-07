module Envsafe
  module Utils
    def self.valid_tag?(tag)
      /\A[a-zA-Z0-9_-]+\z/.match?(tag)
    end

    def self.invalid_tag?(tag)
      not(valid_tag?(tag))
    end

    def self.unique_tag?(tag, back_stack)
      back_stack.each do |entry|
        return false if tag == entry["tag"]
      end

      true
    end
  end
end
