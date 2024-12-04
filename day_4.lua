require "utils/strings"
require "utils/sets"

local input_file, error_msg = io.open("inputs\\day4input.txt", "r");
if not input_file then
    print(error_msg);
    return;
end

function SolveFirstPart()
    local start_time = os.clock();
    local solution = 0;
    
    local extract_letters = function(line)
        local extracted_letters = {}
        for c in string.gmatch(line, "%w") do
            table.insert(extracted_letters, c)
        end
        return extracted_letters
    end

    local check_xmas_count_for_coords = function(array, x, y)
        local XMAS = "XMAS"
        local SAMX = "SAMX"

        local WIDTH = #array[1]

        local count = 0

        local tested_word
        -- right
        if WIDTH - x >= 3 then 
            tested_word = array[y][x] .. array[y][x + 1] .. array[y][x + 2] .. array[y][x + 3]
            if tested_word == XMAS or tested_word == SAMX then count = count + 1 end
        end

        -- right-up
        if WIDTH - x >= 3 and y >= 4 then 
            tested_word = array[y][x] .. array[y - 1][x + 1] .. array[y - 2][x + 2] .. array[y - 3][x + 3]
            if tested_word == XMAS or tested_word == SAMX then count = count + 1 end
        end

        -- up
        if y >= 4 then 
            tested_word = array[y][x] .. array[y - 1][x] .. array[y - 2][x] .. array[y - 3][x]
            if tested_word == XMAS or tested_word == SAMX then count = count + 1 end
        end

        -- left-up
        if x >= 4 and y >= 4 then 
            tested_word = array[y][x] .. array[y - 1][x - 1] .. array[y - 2][x - 2] .. array[y - 3][x - 3]
            if tested_word == XMAS or tested_word == SAMX then count = count + 1 end
        end

        return count
    end

    local letter_table = {}
    for line in input_file:lines() do
        table.insert(letter_table, extract_letters(line))
    end
    input_file:seek("set", 0);

    for y = 1, #letter_table do
        for x = 1, #letter_table[y] do
            solution = solution + check_xmas_count_for_coords(letter_table, x, y)
        end
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

    local extract_letters = function(line)
        local extracted_letters = {}
        for c in string.gmatch(line, "%w") do
            table.insert(extracted_letters, c)
        end
        return extracted_letters
    end

    local check_x_mas_count_for_coords = function(array, x, y)
        local MAS = "MAS"
        local SAM = "SAM"

        local WIDTH = #array[1]
        local HEIGHT = #array

        if x == 1 or x == WIDTH or y == 1 or y == HEIGHT then return 0 end

        local right_up = array[y + 1][x - 1] .. array[y][x] .. array[y - 1][x + 1]
        local left_up = array[y - 1][x - 1] .. array[y][x] .. array[y + 1][x + 1]

        if (right_up == MAS or right_up == SAM) and (left_up == MAS or left_up == SAM) then 
            return 1
        else 
            return 0
        end
    end

    local letter_table = {}
    for line in input_file:lines() do
        table.insert(letter_table, extract_letters(line))
    end
    input_file:seek("set", 0);

    for y = 1, #letter_table do
        for x = 1, #letter_table[y] do
            solution = solution + check_x_mas_count_for_coords(letter_table, x, y)
        end
    end

    local end_time = os.clock();
    local final_time = end_time - start_time;

    print("Second part solution!");
    print(string.format("The solution is %d", solution));
    print(string.format("The solution took %f seconds", final_time));
end

SolveFirstPart();
SolveSecondPart();