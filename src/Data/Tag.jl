include("../Utils/LocalizedString.jl")
include("DataObject.jl")

struct Tag <: DataObject
    id
    name
    description
    group
    version
    "create a Tag object from a JSON Tag object"
    Tag(x) = let attribs = x["attributes"]; new(x["id"], LocalizedString(attribs["name"]), LocalizedString(attribs["description"]), Int(attribs["version"])) end;
end

getid(x::Tag) = x.id
Base.show(io::IO, ::MIME"text/plain", z::Tag) = print(io, z)
Base.show(io::IO, z::Tag) = print(io, z.name.en)