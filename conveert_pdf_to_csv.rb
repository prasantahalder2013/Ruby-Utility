require 'pdf-reader'
require 'csv'
require 'json'

# Read PDF file
file_path = 'STD_codes_List.pdf'
reader = PDF::Reader.new(file_path)

# Extract text from PDF
text = ""
reader.pages.each do |page|
  text += page.text
end
puts "Text:::::::::::::#{text}"
# Process text to extract STD codes
lines = text.split("\n")
std_codes = []

lines.each do |line|
  if line.match?(/\d{1,4}/)
    columns = line.split
    std_code = {
      sl_no: columns[0],
      sdca_name: columns[1],
      std_code: columns[2],
      state_ldca_name: columns[3..-1].join(" ")
    }
    std_codes << std_code
  end
end

# Save to CSV
# CSV.open("std_codes.csv", "wb") do |csv|
#   csv << ["Sl. No.", "SDCA Name", "STD Code", "State LDCA Name"]
#   std_codes.each do |code|
#     csv << [code[:sl_no], code[:sdca_name], code[:std_code], code[:state_ldca_name]]
#   end
# end

# Save to JSON
File.open("std_codes.json", "w") do |file|
  file.write(JSON.pretty_generate(std_codes))
end

puts "Conversion completed. Files saved as std_codes.csv and std_codes.json."