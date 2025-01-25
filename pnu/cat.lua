local args = {...}

if #args == 0 then
    print("Usage: cat <file>")
    return
end

local file_arg = args[1]

local full_path
if fs.exists(file_arg) then
    full_path = file_arg
else
    local current_dir = shell.dir()
    full_path = fs.combine(current_dir, file_arg)
end

local file = fs.open(full_path, "r")
if not file then
    print("cat: " .. file_arg .. ": No such file or directory")
    return
end

local content = file.readAll()
print(content)
file.close()
