local args = {...}

if #args < 1 then
    print("Usage: less <filename>")
    return
end

local filename = shell.resolve(args[1])

local file = fs.open(filename, "r")
if not file then
    print("File not found: " .. filename)
    return
end

local lines = {}
while true do
    local line = file.readLine()
    if not line then break end
    table.insert(lines, line)
end
file.close()

local width, height = term.getSize()
local page = 1
local totalPages = math.ceil(#lines / height)

local function displayPage(page)
    term.clear()
    term.setCursorPos(1, 1)
    for i = 1, height do
        local lineIndex = (page - 1) * height + i
        if lines[lineIndex] then
            print(lines[lineIndex])
        end
    end
    print(string.format("[Page %d/%d] - Press 'q' to quit", page, totalPages))
end

displayPage(page)

while true do
    local event, key = os.pullEvent("key")
    if key == keys.q then
        term.clear()
        term.setCursorPos(1, 1)
        return
    elseif key == keys.down and page < totalPages then
        page = page + 1
        displayPage(page)
    elseif key == keys.up and page > 1 then
        page = page - 1
        displayPage(page)
    end
end
