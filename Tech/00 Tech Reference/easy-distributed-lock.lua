-- abstract : get key 
-- if key is expected then delete it
-- if key is not expected then pass this process
-- return true if key is expected and deleted
-- return false if key is not expected
local key = KEYS[1]
local expected = ARGV[1]
local value = redis.call('get', key)
if (value == expected)
then 
    local isDel = redis.call('del', key) 
end
return isDel == 1
 