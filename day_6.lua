require "utils/strings"
require "utils/sets"

local input_file, error_msg = io.open("inputs\\day6input.txt", "r");
if not input_file then
    print(error_msg);
    return;
end

function SolveFirstPart()
    local start_time = os.clock();
    local solution = 0;

    local UP_DIR = 0
    local RIGHT_DIR = 1
    local DOWN_DIR = 2
    local LEFT_DIR = 3

    local current_dir = UP_DIR
    local current_pos = {}

    local parse_map_line = function(line)
        local parsed_line = {}
        local start_found = false
        local i = 1
        for c in string.gmatch(line, ".") do
            if c == "." then
                table.insert(parsed_line, 0)
            elseif c == "#" then
                table.insert(parsed_line, 2)
            elseif c == "^" then
                table.insert(parsed_line, 1)
                start_found = true
                current_pos.x = i
            end
            i = i + 1
        end
        return parsed_line, start_found
    end

    local mark_path_on_map = function(map, direction, starting_point)
        local x = starting_point.x
        local y = starting_point.y

        local move_pos = function(dir, x, y)
            if dir == UP_DIR then return x, y - 1
            elseif dir == RIGHT_DIR then return x + 1, y
            elseif dir == DOWN_DIR then return x, y + 1
            elseif dir == LEFT_DIR then return x - 1, y
            end
        end

        local get_new_dir = function(dir)
            return (dir + 1) % 4
        end

        while true do
            local new_x, new_y = move_pos(direction, x, y)
            if new_x < 1 or new_x > #map[1] or new_y < 1 or new_y > #map then
                return true, get_new_dir(direction), {x = new_x, y = new_y}
            end

            if map[new_y][new_x] == 2 then break end
            x = new_x
            y = new_y
            map[y][x] = 1
        end

        return false, get_new_dir(direction), {x = x, y = y}
    end
    
    local lab_map = {}
    local i = 1
    for line in input_file:lines() do
        local lab_line, start_found = parse_map_line(line)
        table.insert(lab_map, lab_line)
        if start_found then current_pos.y = i end
        i = i + 1
    end
    input_file:seek("set", 0);

    local guard_exited = false
    while not guard_exited do
        guard_exited, current_dir, current_pos = mark_path_on_map(lab_map, current_dir, current_pos)
    end

    for y_idx = 1, #lab_map do
        for x_idx = 1, #lab_map[1] do
            if lab_map[y_idx][x_idx] == 1 then solution = solution + 1 end
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

    local UP_DIR = 0
    local RIGHT_DIR = 1
    local DOWN_DIR = 2
    local LEFT_DIR = 3

    local current_dir = UP_DIR
    local starting_pos = {}
    local current_pos = {}

    local parse_map_line = function(line)
        local parsed_line = {}
        local start_found = false
        local i = 1
        for c in string.gmatch(line, ".") do
            if c == "." then
                table.insert(parsed_line, 0)
            elseif c == "#" then
                table.insert(parsed_line, 2)
            elseif c == "^" then
                table.insert(parsed_line, 1)
                start_found = true
                starting_pos.x = i
            end
            i = i + 1
        end
        return parsed_line, start_found
    end

    local mark_path_on_map = function(map, direction, starting_point)
        local x = starting_point.x
        local y = starting_point.y

        local move_pos = function(dir, x, y)
            if dir == UP_DIR then return x, y - 1
            elseif dir == RIGHT_DIR then return x + 1, y
            elseif dir == DOWN_DIR then return x, y + 1
            elseif dir == LEFT_DIR then return x - 1, y
            end
        end

        local get_new_dir = function(dir)
            return (dir + 1) % 4
        end

        while true do
            local new_x, new_y = move_pos(direction, x, y)
            if new_x < 1 or new_x > #map[1] or new_y < 1 or new_y > #map then
                return true, get_new_dir(direction), {x = new_x, y = new_y}
            end

            if map[new_y][new_x] == 2 then break end
            x = new_x
            y = new_y
            map[y][x] = 1
        end

        return false, get_new_dir(direction), {x = x, y = y}
    end
    
    local lab_map = {}
    local i = 1
    for line in input_file:lines() do
        local lab_line, start_found = parse_map_line(line)
        table.insert(lab_map, lab_line)
        if start_found then starting_pos.y = i end
        i = i + 1
    end
    input_file:seek("set", 0);

    current_pos = starting_pos
    local guard_exited = false
    while not guard_exited do
        guard_exited, current_dir, current_pos = mark_path_on_map(lab_map, current_dir, current_pos)
    end

    --[[:eyes:]]

    local end_time = os.clock();
    local final_time = end_time - start_time;

    print("Second part solution!");
    print(string.format("The solution is %d", solution));
    print(string.format("The solution took %f seconds", final_time));
end

SolveFirstPart();
SolveSecondPart();