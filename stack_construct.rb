require 'json'
require 'pry'

input_file = ARGV[0]
output_file = ARGV[1]

json_file = JSON.parse( IO.read( input_file ))

error =  json_file["error"]

output_string = ""
output_string = output_string
    .concat(error["className"])
    .concat(": ")
    .concat(error["message"])
    .concat("\n")

error["stackTrace"].each do |stack_line|
    output_string = output_string
        .concat("  at ")
        .concat(stack_line["className"])
        .concat(stack_line["methodName"])
        .concat("(")
        .concat(stack_line["fileName"])
        .concat(":")
        .concat(stack_line["lineNumber"].to_s)
        .concat(")\n")
end

inner_error = error["innerError"]




binding.pry
