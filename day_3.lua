require "utils/strings"
require "utils/sets"

local input_file, error_msg = io.open("inputs\\day3input.txt", "r");
if not input_file then
    print(error_msg);
    return;
end

function SolveFirstPart()
    local start_time = os.clock();
    local solution = 0;
    
    local mul_pattern = "mul%((%d+),(%d+)%)"

    for line in input_file:lines() do
        for left, right in string.gmatch(line, mul_pattern) do
            solution = solution + (tonumber(left) * tonumber(right))
        end
    end
    input_file:seek("set", 0);

    local end_time = os.clock();
    local final_time = end_time - start_time;
   
    print("First part solution!");
    print(string.format("The solution is %d", solution));
    print(string.format("The solution took %f seconds", final_time));
end


function SolveSecondPart()
    local start_time = os.clock();
    local solution = 0;

    local mul_pattern = "mul%((%d+),(%d+)%)"
    local enabled_pattern = "(.-)don't%(%)(.*)"
    local disabled_pattern = "(.-)do%(%)(.*)"
    
    local get_mul_result_from_string = function(string_to_check)
        local result = 0
        for left, right in string.gmatch(string_to_check, mul_pattern) do
            result = result + (tonumber(left) * tonumber(right))
        end
        return result
    end

    local enabled = true
    for line in input_file:lines() do
        while #line > 0 do
            if enabled then
                local string_to_test, rest_of_string = string.gmatch(line, enabled_pattern)()
                if string_to_test then
                    solution = solution + get_mul_result_from_string(string_to_test)
                    line = rest_of_string
                    enabled = false
                else
                    solution = solution + get_mul_result_from_string(line)
                    line = ""
                end
            else
                local _, rest_of_string = string.gmatch(line, disabled_pattern)()
                if rest_of_string then
                    line = rest_of_string
                    enabled = true
                else
                    line = ""
                end
            end
        end
    end
    input_file:seek("set", 0);

    local end_time = os.clock();
    local final_time = end_time - start_time;

    print("Second part solution!");
    print(string.format("The solution is %d", solution));
    print(string.format("The solution took %f seconds", final_time));
end

SolveFirstPart();
SolveSecondPart();