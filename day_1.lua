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
        table.insert(left_list, tonumber(num1))
        table.insert(right_list, tonumber(num2))
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

    local left_array = {}
    local right_map = {}

    for line in input_file:lines() do
        local num1, num2 = SplitString(line, " ")
        assert(num1 and num2)
        table.insert(left_array, tonumber(num1))
        local num2i = tonumber(num2)
        if right_map[num2i] == nil then
            right_map[num2i] = 1
        else
            right_map[num2i] = right_map[num2i] + 1
        end
    end
    input_file:seek("set", 0);

    for i = 1, #left_array do
        local multiplier = right_map[left_array[i]] and right_map[left_array[i]] or 0
        solution = solution + (left_array[i] * multiplier)
    end

    local end_time = os.clock();
    local final_time = end_time - start_time;

    print("Second part solution!");
    print(string.format("The solution is %d", solution));
    print(string.format("The solution took %f seconds", final_time));
end

SolveFirstPart();
SolveSecondPart();