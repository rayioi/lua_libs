-- 实现skiplist
-- 跳表是一种有序的数据结构，它是一种插入、删除、查找都是 O(log n) 的数据结构。


local mrandom = math.random
local tinsert = table.insert

local SkipList = {}
SkipList.__index = SkipList

-- 获取跳表中元素的数量
function SkipList:size()
    return self.length
end

-- 插入元素
function SkipList:insert(key, value)
    local update = {}
    local current = self.head
    local i = self.level

    while i >= 0 do
        while current.next[i] and current.next[i].key < key do
            current = current.next[i]
        end

        update[i] = current
        i = i - 1
    end

    current = current.next[0]

    if current and current.key == key then
        current.value = value
    else
        local level = self:_randomLevel()
        if level > self.level then
            for i = self.level + 1, level do
                update[i] = self.head
            end

            self.level = level
        end

        current = {
            key = key,
            value = value,
            level = level,
            next = {},
        }

        for i = 0, level do
            current.next[i] = update[i].next[i]
            update[i].next[i] = current
        end

        self.length = self.length + 1
    end
end

-- 删除元素
function SkipList:delete(key)
    local update = {}
    local current = self.head
    local i = self.level

    while i >= 0 do
        while current.next[i] and current.next[i].key < key do
            current = current.next[i]
        end

        update[i] = current
        i = i - 1
    end

    current = current.next[0]

    if current and current.key == key then
        for i = 0, self.level do
            if update[i].next[i] ~= current then
                break
            end

            update[i].next[i] = current.next[i]
        end

        while self.level > 0 and self.head.next[self.level] == nil do
            self.level = self.level - 1
        end

        self.length = self.length - 1
    end
end

-- 查找元素
function SkipList:find(key)
    local current = self.head
    local i = self.level

    while i >= 0 do
        while current.next[i] and current.next[i].key < key do
            current = current.next[i]
        end

        i = i - 1
    end

    current = current.next[0]

    if current and current.key == key then
        return current.value
    end
end

-- 查找范围内的元素
function SkipList:range(from, to)
    local current = self.head
    local i = self.level
    local result = {}

    while i >= 0 do
        while current.next[i] and current.next[i].key < from do
            current = current.next[i]
        end

        i = i - 1
    end

    current = current.next[0]

    while current and current.key <= to do
        tinsert(result, current.value)
        current = current.next[0]
    end

    return result
end

-- 随机生成层数
function SkipList:_randomLevel()
    local level = 0
    while mrandom() < 0.5 do
        level = level + 1
    end

    return level
end

-- 返回跳表的字符串表示
function SkipList:__tostring()
    local str = ""
    local current = self.head.next[0]

    while current do
        str = str .. current.key .. " "
        current = current.next[0]
    end

    return str
end

-- 遍历跳表
function SkipList:__pairs()
    local current = self.head.next[0]

    return function()
        if current then
            local key = current.key
            local value = current.value
            current = current.next[0]
            return key, value
        end
    end
end

-- 定义跳表类
function SkipList.new()
    local o = {
        -- 跳表的头结点
        head = {
            level = 0,
            next = {},
        },
 
        -- 跳表的最大层数
        level = 0,
        -- 跳表中元素的数量
        length = 0,
    }

    setmetatable(o, SkipList)
    return o
end

return SkipList