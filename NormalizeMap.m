function [normalizedMap] = NormalizeMap(map)
    normalizedMap = map ./ max(max(map));
end

