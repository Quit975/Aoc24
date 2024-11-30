function TrimString(input)
    local res = string.gsub(input, "^%s+", "");
    res = string.gsub(res, "%s+$", "");
    return res;
end

function SplitString(input, splitting_character)
    local idx = string.find(input, splitting_character);
    if not idx then return nil end;

    local left = string.sub(input, 1, idx - 1);
    local right = string.sub(input, idx + 1, string.len(input));
    return TrimString(left), TrimString(right);
end