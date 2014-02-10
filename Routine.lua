--[[
  Coroutine-Management-System (CMS) v2.0 [Updated: 10 Feb 2014]
  
  Copyright © 2014 Joshua Asbury a.k.a. theoriginalbit [theoriginalbit@gmail.com]

  Permission is hereby granted, free of charge, to any person obtaining a copy
  of this software and associated documentation files (the "Software"), to deal
  in the Software without restriction, including without limitation the rights
  to use, copy, modify, merge, publish, distribute, and/or sublicense copies
  of the Software, and to permit persons to whom the Software is furnished to
  do so, subject to the following conditions:

  - The above copyright notice and this permission notice shall be included in
    all copies or substantial portions of the Software;
  - Visible credit is given to the original author;
  - The software is distributed in a non-profit way;

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
  THE SOFTWARE.
--]]

local function safePairs(t)
  local keys = {}
  for k,v in pairs(t) do
    keys[#keys+1] = k
  end
  local i = 0
  return function()
    i = i + 1
    return keys[i], t[keys[i]]
  end
end

local nextId
do
  local _NEXTID = 0
  nextId = function()
    local temp = _NEXTID
    _NEXTID = _NEXTID + 1
    return temp
  end
end

local _CURRENTROUTINEID = nil

local function resolveIdentifier(ident)
  if type(ident) == "number" then
    if _ROUTINES[ident] then
      return ident
    end
  elseif type(ident) == "string" then
    local id = _NAMETOID[ident]
    if id and _ROUTINES[id] then
      return id
    end
  elseif type(ident) == "nil" then
    return _CURRENTROUTINEID
  end
  error("Invalid identifier", 3)
end


local _ROUTINES = {}
local _NAMETOID = {}

local function resume(co, ...)
  local ok, param
  if coroutine.status(co.thread) ~= "dead" then
    _CURRENTROUTINEID = co.id
    ok, param = coroutine.resume(co.thread, ...)
    if not ok then
      error(param, 3)
    end
  end
  if coroutine.status(co.thread) == "dead" then
    _ROUTINES[co.id] = nil
    _NAMETOID[co.name] = nil
  end
  _CURRENTROUTINEID = nil
  return param
end

function routineStatus(id)
  return coroutine.status(resolveIdentifier(id))
end

function createCoroutine(name,func)
  if type(name) ~= "string" then
    error("Expected coroutine name", 2)
  end
  if type(func) == "function" then
    func = coroutine.create(func)
  end
  if type(func) == "thread" then
    local id = nextId()
    _NAMETOID[name] = id
    _ROUTINES[id] = {id=id; name=name; isPaused=false; thread=func}
    return id
  end
  return nil
end

function stopCoroutine(id)
  local co = _ROUTINES[resolveIdentifier(id)]
  if coroutine.status(co.thread) ~= "dead" then
    resume(co, "SIG_STOP") -- warn of impending stop
    if coroutine.status(co.thread) == "dead" then
      return true
    end
    return killCoroutine(id)
  end
  return false
end

function killCoroutine(id)
  local co = _ROUTINES[resolveIdentifier(id)]
  if coroutine.status(co.thread) ~= "dead" then
    resume(co, "SIG_KILL") -- warn of impending kill
    _ROUTINES[co.id] = nil -- dereference to have the gc clean it up
    _NAMETOID[co.name] = nil
    return true
  end
  return false
end

function pauseCoroutine(id)
  local co = _ROUTINES[resolveIdentifier(id)]
  if coroutine.status(co.thread) ~= "dead" then
    co.isPaused = true
    return true
  end
  error("Cannot pause a dead coroutine", 2)
end

function resumeCoroutine(id)
  local co = _ROUTINES[resolveIdentifier(id)]
  if coroutine.status(co.thread) ~= "dead" then
    co.isPaused = false
    return true
  end
  error("Cannot resume a dead coroutine", 2)
end

function isCoroutinePaused(id)
  local co = _ROUTINES[resolveIdentifier(id)]
  return co.isPaused
end

function getCoroutine(id)
  return _ROUTINES[resolveIdentifier(id)].thread
end

function run()
  local eventData = {}
  local filters = {}

  while true do
    for id, routine in safePairs(_ROUTINES) do
      if not routine.isPaused and (not filters[id] or filters[id] == eventData[1] or eventData[1] == "terminate") then
        local param = resume(resolveIdentifier(id), unpack(eventData))
        filters[id] = param
      end
    end
    eventData = {coroutine.yield()}
  end
end