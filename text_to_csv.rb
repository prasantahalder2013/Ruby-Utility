require 'csv'
require 'json'

# Define the input and output file paths
input_file = 'code.txt'
csv_output_file = 'output.csv'
json_output_file = 'output.json'

data_hash = { "data" => {} }

# Read the input file
lines = File.readlines(input_file)

# Open the output CSV file
CSV.open(csv_output_file, 'wb') do |csv|
  # Write the header row
  csv << ['SL/NO', 'State', 'District', 'Sub-district', 'Code Number']

  # Process each line in the input file
  lines.each do |line|
    # Split the line by whitespace
    columns = line.strip.split(/\s{2,}/)
    # Write the columns to the CSV file
    if columns.size != 5
        puts "Check::::#{columns}"
    end
    csv << columns

    slno = columns[0]
    state = columns[1]
    district = columns[2]
    sub_district = columns[3]
    code = columns[4]
    data_hash["data"]["std:#{code}"] = district.downcase
  end
end

File.open(json_output_file, 'w') do |file|
    file.write(JSON.pretty_generate(data_hash))
end

puts "CSV file has been generated successfully."