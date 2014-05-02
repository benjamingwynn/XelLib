-- > "Character count in Lua" - lua_character_count.lua
-- >> Created by Amir Salihefendic (http://amix.dk/)
-- >> Source: http://amix.dk/blog/post/19462

-- >>> external\lua_character_count.lua
-- >>> Counts the amount of a certain character in a string

function char_count(str, char) 
    if not str then
        return 0
    end

    local count = 0 
    local byte_char = string.byte(char)
    for i = 1, #str do
        if string.byte(str, i) == byte_char then
            count = count + 1 
        end 
    end 
    return count
end


print(char_count("aa aahh a", "a"))
print(char_count("", "a"))
print(char_count("aloha", "a"))