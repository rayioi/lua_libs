-- Desc: Unit tests for the SkipList data structure
local SkipList = require "datastructs.skiplist"

print("SkipList test start")

-- 测试跳表插入
local function test_insert()
    local skiplist = SkipList.new()
    skiplist:insert(1, 1)
    skiplist:insert(2, 2)
    skiplist:insert(3, 3)
    skiplist:insert(4, 4)
    skiplist:insert(5, 5)
    skiplist:insert(6, 6)
    skiplist:insert(7, 7)
    skiplist:insert(8, 8)

    assert(skiplist:size() == 8)
    assert(skiplist:find(1) == 1)
    assert(skiplist:find(2) == 2)
    assert(skiplist:find(3) == 3)
    assert(skiplist:find(4) == 4)
    assert(skiplist:find(5) == 5)
    assert(skiplist:find(6) == 6)
    assert(skiplist:find(7) == 7)
    assert(skiplist:find(8) == 8)
end

-- 测试跳表删除
local function test_delete()
    local skiplist = SkipList.new()
    skiplist:insert(1, 1)
    skiplist:insert(2, 2)
    skiplist:insert(3, 3)
    skiplist:insert(4, 4)
    skiplist:insert(5, 5)
    skiplist:insert(6, 6)
    skiplist:insert(7, 7)
    skiplist:insert(8, 8)

    assert(skiplist:size() == 8)
    assert(skiplist:find(1) == 1)
    assert(skiplist:find(2) == 2)
    assert(skiplist:find(3) == 3)
    assert(skiplist:find(4) == 4)
    assert(skiplist:find(5) == 5)
    assert(skiplist:find(6) == 6)
    assert(skiplist:find(7) == 7)
    assert(skiplist:find(8) == 8)

    skiplist:delete(1)
    assert(skiplist:size() == 7)
    assert(skiplist:find(1) == nil)
    assert(skiplist:find(2) == 2)
    assert(skiplist:find(3) == 3)
    assert(skiplist:find(4) == 4)
    assert(skiplist:find(5) == 5)
    assert(skiplist:find(6) == 6)
    assert(skiplist:find(7) == 7)
    assert(skiplist:find(8) == 8)

    skiplist:delete(8)
    assert(skiplist:size() == 6)
    assert(skiplist:find(1) == nil)
    assert(skiplist:find(2) == 2)
    assert(skiplist:find(3) == 3)
    assert(skiplist:find(4) == 4)
    assert(skiplist:find(5) == 5)
    assert(skiplist:find(6) == 6)
    assert(skiplist:find(7) == 7)
    assert(skiplist:find(8) == nil)
end

-- 测试跳表遍历
local function test_traverse()
    local skiplist = SkipList.new()
    skiplist:insert(1, 1)
    skiplist:insert(2, 2)
    skiplist:insert(3, 3)
    skiplist:insert(4, 4)
    skiplist:insert(5, 5)
    skiplist:insert(6, 6)
    skiplist:insert(7, 7)
    skiplist:insert(8, 8)

    local count = 0
    for key, value in pairs(skiplist) do
        count = count + 1
        assert(key == value, "key: " .. key .. " value: " .. value)
    end

    assert(count == 8, "count: " .. count)
end

-- 测试跳表范围查找
local function test_range()
    local skiplist = SkipList.new()
    skiplist:insert(1, 1)
    skiplist:insert(2, 2)
    skiplist:insert(3, 3)
    skiplist:insert(4, 4)
    skiplist:insert(5, 5)
    skiplist:insert(6, 6)
    skiplist:insert(7, 7)
    skiplist:insert(8, 8)

    local ret = skiplist:range(3, 6)
    assert(#ret == 4)
    assert(ret[1] == 3)
    assert(ret[2] == 4)
    assert(ret[3] == 5)
    assert(ret[4] == 6)
end

-- 测试打印跳表
local function test_print()
    local skiplist = SkipList.new()
    skiplist:insert(1, 1)
    skiplist:insert(2, 2)
    skiplist:insert(3, 3)
    skiplist:insert(4, 4)
    skiplist:insert(5, 5)
    skiplist:insert(6, 6)
    skiplist:insert(7, 7)
    skiplist:insert(8, 8)

    print(tostring(skiplist))
end

test_insert()
test_delete()
test_traverse()
test_range()
test_print()


