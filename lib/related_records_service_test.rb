require 'minitest/autorun'
require 'rexml/document'
require_relative 'related_records_service'

class RelatedRecordsServiceTest < Minitest::Test
  def setup
    # Create 5 records with distinct colors
    xml = <<-XML
    <catalogue>
      <record><id>1</id><image background="rgb(255,0,0)">red.png</image><rtitle>Red</rtitle></record>
      <record><id>2</id><image background="rgb(0,255,0)">green.png</image><rtitle>Green</rtitle></record>
      <record><id>3</id><image background="rgb(0,0,255)">blue.png</image><rtitle>Blue</rtitle></record>
      <record><id>4</id><image background="rgb(255,255,0)">yellow.png</image><rtitle>Yellow</rtitle></record>
      <record><id>5</id><image background="rgb(255,0,255)">magenta.png</image><rtitle>Magenta</rtitle></record>
    </catalogue>
    XML
    @records = REXML::Document.new(xml).get_elements('//record')
    @service = RelatedRecordsService.new(@records)
  end

  def test_find_related_returns_4_closest
    current = @records[0] # Red
    related = @service.find_related(current, 4)
    # Should not include itself
    refute_includes related, current
    # Should return 4 records
    assert_equal 4, related.size
    # Should include the closest colors (yellow and magenta are closer to red than green or blue)
    related_titles = related.map { |r| r.elements['rtitle'].text }
    assert_includes related_titles, 'Yellow'
    assert_includes related_titles, 'Magenta'
  end
end
