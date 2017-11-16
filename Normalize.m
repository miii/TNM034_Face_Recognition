function [normalizedMap] = Normalize(map)
    normalizedMap = map ./ max(max(map));
end

