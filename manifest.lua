Manifest = {}
Manifest.__index = Manifest

function Manifest.create(file)
    local manifest = {}
    setmetatable(manifest, Manifest)
    manifest.file = file
    manifest.manifest = {}
    return manifest
end

function Manifest:read()
    f = assert(io.open(self.file, "r"))
    for line in f:lines() do
        line = string.gsub(line, "%s+", "")
        if line ~= "" then
            table.insert(self.manifest, line)
        end
    end
end

function Manifest:parse(s)
    DISTRO = "^%s*([%w-.]+)"
    VERSION = "^%s*([><])%s*([%w-.*_!+]+)" --- doesn't match < or > alone
    result = {}
    --- parse distro
    _,pos,distro = string.find(str, DISTRO)
    if distro == nil then
        msg = string.format("failed to parse distro from: %s ", str)
        error(msg)
    end
    result.distro = distro
    --- parse versions
    result.versions = {}
    str = string.sub(str, pos + 1)
    repeat
        _,j,operator,value = string.find(str, VERSION)
        if operator == nil or value == nil then
            msg = string.format("failed to parse version from: %s ", str)
            error(msg)
        end
        table.insert(result.versions, {operator, value})
        
        eol = true
    until eol == true
    return result
end

function Manifest:printparse(p)
    print(string.format("Distro: %s", p.distro))
    for op,item in pairs(p.versions) do
        print(string.format("  - Op: %s, Ver: %s", item[1], item[2]))
    end
end

function Manifest:compat(s)
    for k,v in pairs(self.manifest) do
        print(k,v)
    end
end

function Manifest:print()
    for k,v in pairs(self.manifest) do
        print(k,v)
    end
end


