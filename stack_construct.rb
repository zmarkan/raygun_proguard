require 'json'
require 'pry'

def parse_stack_line(stack_line)
    "".concat("  at ")
    .concat(stack_line["className"])
    .concat(".")
    .concat(stack_line["methodName"])
    .concat("(")
    .concat(stack_line["fileName"])
    .concat(":")
    .concat(stack_line["lineNumber"].to_s)
    .concat(")\n")
end

def parse_error(error, output_string, isInnerError)
    if(isInnerError)
        output_string = output_string.concat("Caused by: ")
    end

    output_string = output_string
        .concat(error["className"])
        .concat(": ")
        .concat(error["message"])
        .concat("\n")

    error["stackTrace"].each do |stack_line|
        output_string = output_string.concat(parse_stack_line(stack_line))
    end


    inner_error = error["innerError"]
    if (inner_error != nil )
        output_string = parse_error(inner_error, output_string, true)
    end


    output_string
end

input_file = ARGV[0]
output_file = ARGV[1]

json_file = JSON.parse( IO.read( input_file ))

error =  json_file["error"]
output_string = parse_error(error, "", false)


File.open(output_file, 'w') { |file| file.write(output_string)}

# end
