require 'lib/dc_commands/dc_command'

class DCKeyCommand < DCCommand
  def initialize(data)
    @data = generate_key(data)
  end

  private
  # By C Erler with suggestions by Robert Klemme.
  # Took the way of combining neighboring characters from the Python code.
  def generate_key(lock)
    # We need a String of at least two bytes.
    raise TypeError, "cannot convert #{lock.class} into String", caller unless lock.respond_to? :to_str
    lock = lock.to_str
    return '' unless lock.length >= 2

    # Transform the input bytes.
    result = Array.new(lock.length) { |i| lock[i - 1] ^ lock[i] }
    result[0] ^= lock[-2] ^ 5

    result.map! do |value|
      # Rotate each byte by four bits.
      value = ((value << 4) | (value >> 4)) & 0b11111111

      # Put the output in the correct format.
      case value
        when 0, 5, 36, 96, 124, 126
          '/%%DCN%03d%%/' % value
        else
          value.chr
      end
    end

    # Combine the parts into the resultant string.
    result.join
  end
end
