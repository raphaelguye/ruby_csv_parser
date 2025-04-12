class Anomaly < Struct.new(:criteria, :category, :group, :stdev_ratio, :raw_entry)
  def to_s
    raw_entry
  end
end
