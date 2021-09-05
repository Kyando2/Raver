module Initialize
    include("./Data/Tag.jl")
    include("./Utils/LocalizedString.jl")
    
    import HTTP
    import JSON

    export generatetags

    const BASE_ENDPOINT = "https://api.mangadex.org"
    const TAGS_ENDPOINT = "/manga/tag"
     
    "parse overload for parsing an http response"
    JSON.parse(x::HTTP.Messages.Response) = JSON.parse(String(x.body))

    """Generates an array of tags Vector{Tags}"""
    generatetags() = map(x -> Tag(x["data"]), JSON.parse(HTTP.request("GET", BASE_ENDPOINT*TAGS_ENDPOINT)))


end
