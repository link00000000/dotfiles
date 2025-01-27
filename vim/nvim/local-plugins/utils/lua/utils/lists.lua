local M = {}

M.NO_INDEX = -1

---Searches the list to see if any element matches the predicate
---@generic T
---@param list T[]
---@param predicate fun(item: T): boolean
M.contains_predicate = function (list, predicate)
  return M.find_first_index_predicate(list, predicate) ~= M.NO_INDEX
end

---Searches the list for all elements matching the predicate
---@generic T
---@param list T[]
---@param predicate fun(item: T): boolean
---@return T[] found_items All items matching the predicate. If not items were found, returns an empty list
M.find_all_predicate = function (list, predicate)
  local items = {}

  local idxs = M.find_all_index_predicate(list, predicate)
  for _, idx in ipairs(idxs) do
    table.insert(items, list[idx])
  end

  return items
end

---Searches this list for the first element matching the predicate
---@generic T
---@param list T[]
---@param predicate fun(item: T): boolean
---@return T? found_item The first item matching the predicate. If no items were found, return nil
M.find_first_predicate = function (list, predicate)
  local idx = M.find_first_index_predicate(list, predicate)

  if idx == M.NO_INDEX then
    return nil
  end

  return list[idx]
end

---Searches this list for the all elements matching the predicate and returns a list of indices for the found items.
---@generic T
---@param list T[]
---@param predicate fun(item: T): boolean
---@return integer[] found_indices The indices of all items matching the predicate. If no items were found, returns an empty list
M.find_all_index_predicate = function (list, predicate)
  ---@type integer[]
  local indices = {}

  for i, v in ipairs(list) do
    if predicate(v) then
      table.insert(indices, i)
    end
  end

  return indices
end

---Searches this list for the first element matching the predicate and returns it's index
---@generic T
---@param list T[]
---@param predicate fun(item: T): boolean
---@return integer found_index The index of the item found. If the item was not found, returns NO_INDEX
M.find_first_index_predicate = function (list, predicate)
  for i, v in ipairs(list) do
    if predicate(v) then
      return i
    end
  end

  return M.NO_INDEX
end

---Creates a new list containing all items from the list that satisfy the predicate
---@generic T
---@param list T[]
---@param predicate fun(item: T): boolean
---@return T[]
M.filter = function (list, predicate)
  local result = {}

  for _, v in ipairs(list) do
    if predicate(v) then
      table.insert(result, v)
    end
  end

  return result
end

---Creates a new list containing all items transformed using the predicate
---@generic TIn
---@generic TOut
---@param list TIn[]
---@param predicate fun(item: TIn): TOut
---@return TOut[]
M.map = function (list, predicate)
  local result = {}

  for _, v in ipairs(list) do
    table.insert(result, predicate(v))
  end

  return result
end

return M
