require 'json'
require 'nokogiri'
require 'pry'
require 'open-uri'
require 'american_date'

class DownloadSheet
  def initialize
    @url = "https://docs.google.com/spreadsheets/d/1eMW9fCpKojUczfb0awdXx0-H924ssyqt97H-vg65x-E/pubhtml#"
    @html = Nokogiri::HTML.parse(open(@url))
    @output = Array.new
  end

  def parse_table
    @html.css("table").first.css("tr").each do |row|
      if row.text != ""
        rowhash = Hash.new
        rowhash[:doc_type] = remap_doc_type(row.css("td")[0].text)
        rowhash[:title] = row.css("td")[3].text
        rowhash[:classification] = row.css("td")[6].text
        rowhash[:case] = "USA v. Manning"
        rowhash[:release_date] = process_date(row.css("td")[11].text)
        rowhash[:url] = row.css("td")[9].text.gsub(".html", ".pdf")
        rowhash[:path] = rowhash[:url].split("/").last
        @output.push(rowhash)
      end
    end
    @output.shift
  end

  # Write out a longer version of doc type
  def remap_doc_type(type)
    case type
    when "AE"
      return "Appellate Exhibit"
    when "DE"
      return "Defense Exhibit"
    when "PE"
      return "Prosecution Exhibit"
    else
      return type
    end
  end

  # Remove and bit from date
  def process_date(date)
    Date.parse(date.split(" and ").first) if date != "Release Date"
  end

  def gen_output
    JSON.pretty_generate(@output)
  end
end

d = DownloadSheet.new
d.parse_table
puts d.gen_output
