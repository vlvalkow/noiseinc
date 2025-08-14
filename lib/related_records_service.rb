class RelatedRecordsService
  def initialize(records)
    @records = records
  end

  def rgb_from_string(str)
    str.match(/rgb\((\d+),\s*(\d+),\s*(\d+)\)/) { |m| [m[1].to_i, m[2].to_i, m[3].to_i] }
  end

  def find_related(current_record, count = 4)
    current_rgb = rgb_from_string(current_record.elements['image']&.attributes['background'])
    related = @records.reject { |r| r.elements['id'].text == current_record.elements['id'].text }
    related = related.map do |r|
      rgb = rgb_from_string(r.elements['image']&.attributes['background'])
      dist = Math.sqrt((current_rgb[0] - rgb[0])**2 + (current_rgb[1] - rgb[1])**2 + (current_rgb[2] - rgb[2])**2)
      { rec: r, dist: dist }
    end
    related.sort_by { |x| x[:dist] }[0, count].map { |x| x[:rec] }
  end
end
