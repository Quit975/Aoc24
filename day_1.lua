require "utils/strings"
require "utils/sets"

local input_file, error_msg = io.open("inputs\\day1input.txt", "r");
if not input_file then
    print(error_msg);
    return;
end

function SolveFirstPart()
    local start_time = os.clock();
    local solution = 0;

    local left_list = {}
    local right_list = {}
    
    for line in input_file:lines() do
        local num1, num2 = SplitString(line, " ")
        table.insert(left_list, num1)
        table.insert(right_list, num2)
    end
    input_file:seek("set", 0);

    table.sort(left_list)
    table.sort(right_list)

    for i = 1, #left_list do
        solution = solution + math.abs(left_list[i] - right_list[i])
    end

    local end_time = os.clock();
    local final_time = end_time - start_time;
   
    print("First part solution!");
    print(string.format("The solution is %d", solution));
    print(string.format("The solution took %f seconds", final_time));
end


function SolveSecondPart()
    local start_time = os.clock();
    local solution = 0;

    for line in input_file:lines() do
        
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