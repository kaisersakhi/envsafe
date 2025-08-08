module Envsafe
  module Utils
    def self.valid_tag?(tag)
      /\A[a-zA-Z0-9_-]+\z/.match?(tag)
    end

    def self.invalid_tag?(tag)
      not valid_tag?(tag)
    end

    def self.tag_present?(tag, back_stack)
      back_stack.any? { |entry| entry["tag"] == tag }
    end

    def self.unique_tag?(tag, back_stack)
      not(tag_present?(tag, back_stack))
    end

    def self.parse_int(num)
      return nil if num.nil?

      Integer(num)
    rescue Error
      nil
    end

    def self.print_with_less(content)
       IO.popen("less", "w") { |io| io.write(content)}
    end
  end
end
