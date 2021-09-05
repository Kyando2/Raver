include("../Utils/LocalizedString.jl")
include("./DataObject.jl")
include("Tag.jl")

struct Manga <: DataObject
    id
    title
    description
    alt_titles
    original_lang
    content_rating
    tags
    Manga(x) = let attribs = x["attributes"]; new(x["id"], LocalizedString(attribs["title"]), LocalizedString(attribs["description"]), map(x -> LocalizedString(x), attribs["altTitles"]), attribs["originalLanguage"], attribs["contentRating"], map(t -> Tag(t), attribs["tags"])) end;
end

getid(x::Manga) = x.id
Base.show(io::IO, ::MIME"text/plain", z::Manga) = print(io, z)
Base.show(io::IO, z::Manga) = print(io, z.title.en)