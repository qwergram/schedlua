--[[
	Queue
--]]
local Queue = {}
setmetatable(Queue, {
	__call = function(self, ...)
		return self:create(...);
	end,
});

local Queue_mt = {
	__index = Queue;
}

Queue.init = function(self, first, last, name)
	first = first or 1;
	last = last or 0;

	local obj = {
		first=first, 
		last=last, 
		name=name};

	setmetatable(obj, Queue_mt);

	return obj
end

Queue.create = function(self, first, last, name)
	first = first or 1
	last = last or 0

	return self:init(first, last, name);
end

--[[
function Queue.new(name)
	return Queue:init(1, 0, name);
end
--]]

function Queue:enqueue(value)
	--self.MyList:PushRight(value)
	value.priority = value.priority or 100
	--print("INSIDE OF PRIORITY QUEUE: PRIORITY: "..value.priority)
	local last = self.last + 1
	self.last = last
	self[last] = value
	--print(self.last)
	return value
end

function Queue:pushFront(value)
	-- PushLeft
	local first = self.first - 1;
	self.first = first;
	self[first] = value;
end

function Queue:dequeue(value)
	-- return self.MyList:PopLeft()
	local first = self.first

	if first > self.last then
		return nil, "list is empty"
	end

	local highest_priority_index = self.first
	local highest_priority = self[first].priority

	for cursor=0, self.last, 1 do
		if self[cursor] then
			if self[cursor].priority < highest_priority then
				highest_priority_index = cursor
				highest_priority = self[cursor].priority
			end
			--print("QUEUE PRIORITY: "..self[cursor].priority)
		end
	end
	
	-- The old code
	local value = self[highest_priority_index]
	self[highest_priority_index] = nil        -- to allow garbage collection
	self.first = highest_priority_index + 1

	return value	
end

function Queue:length()
	return self.last - self.first+1
end

-- Returns an iterator over all the current 
-- values in the queue
function Queue:Entries(func, param)
	local starting = self.first-1;
	local len = self:length();

	local closure = function()
		starting = starting + 1;
		return self[starting];
	end

	return closure;
end


return Queue;
