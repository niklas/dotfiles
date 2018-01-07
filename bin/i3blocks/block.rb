load File.expand_path('../../pbar', __FILE__)

class Block
  def value
    @value ||= get_value || fail(%Q[Can't find #{self.class} information])
  end

  def to_i3bar
    "".tap do |out|
      out << full_text + "\n"
      out << short_text + "\n"
      out << color + "\n"
    end
  end

  def full_text
    raise NotImplementedError, "implement full_text"
  end

  def short_text
    raise NotImplementedError, "implement short_text"
  end

  def color
    ''
  end

  def get_value
    raise NotImplementedError, "will be saved in @value, nil with cause fail"
  end


end
