require "utils/strings"
require "utils/sets"

local input_file, error_msg = io.open("inputs\\day5input.txt", "r");
if not input_file then
    print(error_msg);
    return;
end

function SolveFirstPart()
    local start_time = os.clock();
    local solution = 0;
    
    local extract_illegal_pairs = function(input_file, illegal_pairs_set)
        for line in input_file:lines() do
            if line == "" then return end

            local left, right = string.gmatch(line, "(%d+)|(%d+)")()
            local illegal_pair = tonumber(right..left)
            Set.Add(illegal_pairs_set, illegal_pair)
        end
    end

    local illegal_pairs = Set.New({})
    extract_illegal_pairs(input_file, illegal_pairs)

    for line in input_file:lines() do
        local sequence = {}
        for num in string.gmatch(line, "%d+") do
            table.insert(sequence, num)
        end

        for i = 1, #sequence - 1 do
            local left = sequence[i]
            for j = i + 1, #sequence do
                local right = sequence[j]

                local pair = tonumber(left .. right)
                if illegal_pairs[pair] then 
                    goto skip 
                end
            end
        end

        local mid_num = tonumber(sequence[(#sequence + 1) / 2])
        solution = solution + mid_num
        ::skip::
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

    local extract_illegal_pairs = function(input_file, illegal_pairs_set)
        for line in input_file:lines() do
            if line == "" then return end

            local left, right = string.gmatch(line, "(%d+)|(%d+)")()
            local illegal_pair = tonumber(right..left)
            Set.Add(illegal_pairs_set, illegal_pair)
        end
    end

    local illegal_pairs = Set.New({})
    extract_illegal_pairs(input_file, illegal_pairs)

    

    for line in input_file:lines() do
        local sequence = {}
        for num in string.gmatch(line, "%d+") do
            table.insert(sequence, num)
        end

        local corrected_sequence = false
        ::restart_check::
        for i = 1, #sequence - 1 do
            local left = sequence[i]
            for j = i + 1, #sequence do
                local right = sequence[j]

                local pair = tonumber(left .. right)
                if illegal_pairs[pair] then
                    corrected_sequence = true
                    local temp = sequence[i]
                    sequence[i] = sequence[j]
                    sequence[j] = temp
                    goto restart_check
                end
            end     
        end

        if corrected_sequence then
            local mid_num = tonumber(sequence[(#sequence + 1) / 2])
            solution = solution + mid_num
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