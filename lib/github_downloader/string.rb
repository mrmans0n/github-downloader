class String
  def self.colorize(text, color_code)
    "\e[#{color_code}m#{text}\e[0m"
  end

  def cyan
    self.class.colorize(self, 36)
  end

  def green
    self.class.colorize(self, 32)
  end

  def yellow
    self.class.colorize(self, 33)
  end

  def red
    self.class.colorize(self, 31)
  end

  def underscore
    self.gsub(/::/, '/').
        gsub(/([A-Z]+)([A-Z][a-z])/, '\1_\2').
        gsub(/([a-z\d])([A-Z])/, '\1_\2').
        tr("-", "_").
        downcase
  end

  def uncapitalize
    self[0, 1].downcase + self[1..-1]
  end

  def blank?
    self.nil? || self.empty?
  end
end