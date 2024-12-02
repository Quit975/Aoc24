require "utils/strings"
require "utils/sets"

local input_file, error_msg = io.open("inputs\\day2input.txt", "r");
if not input_file then
    print(error_msg);
    return;
end

function SolveFirstPart()
    local start_time = os.clock();
    local solution = 0;

    local parse_report = function(line)
        local MIN_SINGLE_DIFF = 1
        local MAX_SINGLE_DIFF = 3

        local first_level, last_level
        
        local left, right = SplitString(line, " ")
        first_level = tonumber(left)

        left, right = SplitString(right, " ")
        last_level = tonumber(left)

        local level_diff = math.abs(last_level - first_level)
        if last_level == first_level or level_diff < MIN_SINGLE_DIFF or level_diff > MAX_SINGLE_DIFF then return 0 end
        local is_increasing = last_level > first_level

        while right do
            local l, r = SplitString(right, " ")

            local current_level
            if r then
                current_level = tonumber(l)
            else
                current_level = tonumber(right)        
            end

            level_diff = math.abs(last_level - current_level)
            if level_diff < MIN_SINGLE_DIFF or level_diff > MAX_SINGLE_DIFF then
                return 0
            end

            if is_increasing then
                if current_level < last_level then 
                    return 0
                end
            else
                if current_level > last_level then
                    return 0
                end
            end

            last_level = current_level
            right = r
        end

        return 1
    end
    
    for line in input_file:lines() do
        solution = solution + parse_report(line)
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

    local extract_report = function(line)
        local result = {}
        local left, right = SplitString(line, " ")
        table.insert(result, tonumber(left))

        while(right) do
            local l, r = SplitString(right, " ")

            if r then
                table.insert(result, tonumber(l))
            else
                table.insert(result, tonumber(right))
            end

            right = r
        end

        return result
    end

    local check_report = function(report)
        local get_report_without_idx = function(report, idx)
            local modified_report = {}
            for i = 1, #report do
                if i == idx then goto continue end
                table.insert(modified_report, report[i])
                ::continue::
            end

            return modified_report
        end

        local check_report_impl = function(report)
            if report[1] == report[2] then return 0 end
            local is_increasing = report[1] < report[2]

            for i = 2, #report do
                if is_increasing then
                    if report[i] <= report[i - 1] then return 0 end
                else
                    if report[i - 1] <= report[i] then return 0 end
                end

                local diff = math.abs(report[i] - report[i-1])
                if diff < 1 or diff > 3 then return 0 end
            end

            return 1
        end

        local result = check_report_impl(report)

        if result == 0 then
            for i = 1, #report do
                result = check_report_impl(get_report_without_idx(report, i))
                if result == 1 then return result end
            end
        end

        return result
    end
    
    for line in input_file:lines() do
        local numbers = extract_report(line)
        solution = solution + check_report(numbers)
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