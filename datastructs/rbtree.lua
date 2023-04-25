-- 红黑树节点颜色
local RED = 0
local BLACK = 1

-- 红黑树节点定义
local RBNode = {}
RBNode.__index = RBNode

function RBNode.new(key, value, color, left, right, parent)
    local node = {}
    node.key = key
    node.value = value
    node.color = color
    node.left = left
    node.right = right
    node.parent = parent
    return setmetatable(node, RBNode)
end

-- 红黑树定义
local RBTree = {
    _nil = RBNode.new(nil, nil, BLACK),
    BLACK = BLACK,
    RED = RED,
}

RBTree.__index = RBTree

function RBTree.new()
    local tree = {}
    tree._root = RBTree._nil
    return setmetatable(tree, RBTree)
end

-- 获取节点的兄弟节点
function RBTree:_get_sibling(node)
    if node.parent == self._nil then
        return self._nil
    end

    if node == node.parent.left then
        return node.parent.right
    else
        return node.parent.left
    end
end

-- 左旋转操作
function RBTree:_left_rotate(node)
    local y = node.right
    node.right = y.left
    if y.left ~= self._nil then
        y.left.parent = node
    end
    y.parent = node.parent
    if node.parent == self._nil then
        self._root = y
    elseif node == node.parent.left then
        node.parent.left = y
    else
        node.parent.right = y
    end
    y.left = node
    node.parent = y
end

-- 右旋转操作
function RBTree:_right_rotate(node)
    local y = node.left
    node.left = y.right
    if y.right ~= self._nil then
        y.right.parent = node
    end
    y.parent = node.parent
    if node.parent == self._nil then
        self._root = y
    elseif node == node.parent.right then
        node.parent.right = y
    else
        node.parent.left = y
    end
    y.right = node
    node.parent = y
end

-- 插入节点操作
function RBTree:insert(key, value)
    local z = RBNode.new(key, value, RED, self._nil, self._nil, self._nil)
    local y = self._nil
    local x = self._root

    -- 找到新节点应该插入的位置
    while x ~= self._nil do
        y = x
        if z.key < x.key then
            x = x.left
        else
            x = x.right
        end
    end

    z.parent = y
    if y == self._nil then
        self._root = z
    elseif z.key < y.key then
        y.left = z
    else
        y.right = z
    end

    -- 调整红黑树
    self:_insert_fixup(z)
end

-- 插入节点后的调整操作
function RBTree:_insert_fixup(node)
    while node.parent and node.parent.color == RED do
        if node.parent == node.parent.parent.left then
            local uncle = node.parent.parent.right
            if uncle.color == RED then
                -- 情况1：如果当前节点的叔叔节点是红色，
                -- 则将当前节点的父亲和叔叔节点的颜色都设置为黑色，
                -- 将当前节点的祖父节点的颜色设置为红色，
                -- 然后将当前节点指向其祖父节点，重新进行检查。
                node.parent.color = BLACK
                uncle.color = BLACK
                node.parent.parent.color = RED
                node = node.parent.parent
            else
                if node == node.parent.right then
                    -- 情况2：如果当前节点的叔叔节点是黑色，
                    -- 且当前节点是其父节点的右孩子，则将当前节点的父节点作为新的当前节点，
                    -- 再对新当前节点进行左旋，将情况2转换为情况3
                    node = node.parent
                    self:_left_rotate(node)
                end
                -- 情况3：如果当前节点的叔叔节点是黑色，
                -- 且当前节点是其父节点的左孩子，则将当前节点的父亲节点设置为黑色，
                -- 祖父节点设置为红色，然后以祖父节点为支点进行右旋
                node.parent.color = BLACK
                node.parent.parent.color = RED
                self:_right_rotate(node.parent.parent)
            end
        else
            local uncle = node.parent.parent.left
            if uncle.color == RED then
                -- 同情况1
                node.parent.color = BLACK
                uncle.color = BLACK
                node.parent.parent.color = RED
                node = node.parent.parent
            else
                if node == node.parent.left then
                    -- 同情况2
                    node = node.parent
                    self:_right_rotate(node)
                end
                -- 同情况3
                node.parent.color = BLACK
                node.parent.parent.color = RED
                self:_left_rotate(node.parent.parent)
            end
        end
    end
    -- 确保根节点始终为黑色
    self._root.color = BLACK
end

-- 删除节点操作
function RBTree:_rb_delete(node)
    local y = node
    local y_original_color = y.color
    local x

    if node.left == self._nil then
        -- 如果该节点没有左子树，则直接用右子树替代该节点
        x = node.right
        self:_rb_transplant(node, node.right)
    elseif node.right == self._nil then
        -- 如果该节点没有右子树，则直接用左子树替代该节点
        x = node.left
        self:_rb_transplant(node, node.left)
    else
        -- 如果该节点同时有左右子树，则找到它的后继节点，用后继节点来代替该节点
        y = self:_tree_minimum(node.right)
        y_original_color = y.color
        x = y.right

        if y.parent == node then
            -- 如果后继节点的父亲是要删除的节点，则用后继节点来代替该节点
            x.parent = y
        else
            -- 否则先用后继节点的右子树替代后继节点，再将后继节点替代要删除的节点
            self:_rb_transplant(y, y.right)
            y.right = node.right
            y.right.parent = y
        end

        -- 将后继节点替代要删除的节点，并将要删除的节点的颜色赋给后继节点
        self:_rb_transplant(node, y)
        y.left = node.left
        y.left.parent = y
        y.color = node.color
    end

    -- 如果要删除的节点是黑色，则需要进行调整操作
    if y_original_color == BLACK then
        self:_delete_fixup(x)
    end
end

-- 交换节点
function RBTree:_rb_transplant(u, v)
    if u.parent == self._nil then
        -- 如果 u 是根节点，则将 v 替换成根节点
        self._root = v
    elseif u == u.parent.left then
        -- 如果 u 是父节点的左子节点，则将 v 替换成 u 的位置
        u.parent.left = v
    else
        -- 否则 u 是父节点的右子节点，则将 v 替换成 u 的位置
        u.parent.right = v
    end

    v.parent = u.parent
end

-- 找到最小节点
function RBTree:_tree_minimum(node)
    while node.left ~= self._nil do
        node = node.left
    end

    return node
end

-- 删除节点后的调整操作
function RBTree:_delete_fixup(x)
    while x ~= self._root and x.color == BLACK do
        if x == x.parent.left then
            local w = x.parent.right
            if w.color == RED then
                -- 情况1: x的兄弟节点w为红色
                w.color = BLACK
                x.parent.color = RED
                self:_left_rotate(x.parent)
                w = x.parent.right
            end
            if w.left.color == BLACK and w.right.color == BLACK then
                -- 情况2: x的兄弟节点w是黑色，w的两个子节点都是黑色
                w.color = RED
                x = x.parent
            else
                if w.right.color == BLACK then
                    -- 情况3: x的兄弟节点w是黑色，w的左子节点是红色，右子节点是黑色
                    w.left.color = BLACK
                    w.color = RED
                    self:_right_rotate(w)
                    w = x.parent.right
                end
                -- 情况4: x的兄弟节点w是黑色，w的右子节点是红色
                w.color = x.parent.color
                x.parent.color = BLACK
                w.right.color = BLACK
                self:_left_rotate(x.parent)
                x = self._root
            end
        else
            local w = x.parent.left
            if w.color == RED then
                -- 情况1: x的兄弟节点w为红色
                w.color = BLACK
                x.parent.color = RED
                self:_right_rotate(x.parent)
                w = x.parent.left
            end
            if w.right.color == BLACK and w.left.color == BLACK then
                -- 情况2: x的兄弟节点w是黑色，w的两个子节点都是黑色
                w.color = RED
                x = x.parent
            else
                if w.left.color == BLACK then
                    -- 情况3: x的兄弟节点w是黑色，w的右子节点是红色，左子节点是黑色
                    w.right.color = BLACK
                    w.color = RED
                    self:_left_rotate(w)
                    w = x.parent.left
                end
                -- 情况4: x的兄弟节点w是黑色，w的左子节点是红色
                w.color = x.parent.color
                x.parent.color = BLACK
                w.left.color = BLACK
                self:_right_rotate(x.parent)
                x = self._root
            end
        end
    end

    x.color = BLACK
end

-- 搜索节点
function RBTree:find(key)
    local current = self._root
    while current ~= self._nil do
        if current.key == key then
            return current
        elseif current.key > key then
            current = current.left
        else
            current = current.right
        end
    end
end

-- 删除节点
function RBTree:delete(key)
    local node = self:find(key)
    if node then
        self:_rb_delete(node)
    end
end

--  中序遍历
function RBTree:inorder_traversal(callback)
    local function inorder_helper(node)
        if node ~= self._nil then
            inorder_helper(node.left)
            callback(node.value)
            inorder_helper(node.right)
        end
    end

    inorder_helper(self.root)
end

function RBTree:size()
    local size = 0
    local stack = {}
    local current = self._root

    while current ~= self._nil or #stack > 0 do
        if current ~= self._nil then
            -- 如果当前节点不是空节点，则将其压入栈中，并将当前节点设置为其左子节点
            table.insert(stack, current)
            current = current.left
        else
            -- 如果当前节点是空节点，则弹出栈顶节点，将节点数量加一，并将当前节点设置为栈顶节点的右子节点
            current = table.remove(stack)
            size = size + 1
            current = current.right
        end
    end

    return size
end

-- 打印树结构
function RBTree:print()
    print("---------------------------------------")
    local function print_helper(node, indent, last)
        if node ~= self._nil then
            io.write(indent)
            if last then
                io.write("└── ")
                indent = indent .. "    "
            else
                io.write("├── ")
                indent = indent .. "│   "
            end

            local sColor = node.color == RED and "RED" or "BLACK"
            print(node.key .. "(" .. sColor .. ")")
            print_helper(node.left, indent, false)
            print_helper(node.right, indent, true)
        end
    end

    print_helper(self._root, "", true)
end

return RBTree