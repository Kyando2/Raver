module Mangadex
    include("./Initialize.jl")
    include("./Data/Manga.jl")
    include("./Exceptions/Search.jl")

    using .Initialize
    import URIs
    import JSON
    import HTTP

    const all_tags = generatetags()

    # Internals
    fix_query_key(k, v) = String(k)
    fix_query_key(k, v::Vector) = String(k) * "[]"
    fix_query_value(v) = v
    fix_query_value(v::Tag) = v.id
    fix_query_value(v::AbstractArray{Tag}) = [x.id for x in v]
    # --

    tag(name::String, lang::String="en") = for x in all_tags if x.name[lang] == name return x end end
    
    """
        search(; <keyword arguments>) -> Vector{Mangadex.Initialize.Manga}
    
    Searches for a manga through the mangadex /manga api with the given arguments

    # Arguments
    - `limit::Int`: the amount of mangas to look for
    - `offset::Int`: how much to offset the search
    - `title::String`: search for a specific title
    - `authors::Vector{String}`: search for specific authors
    - `artists::Vectors{String}`: search for specific artists
    - `year::Int`: search for a specific year of release
    - `includedtags::Vector{String}`: search for a list of tags
    - `excludedtags::Vector{String}`: do not search for a list of tags
    - `excluded_tags_mode::String`: "AND" or "OR" mode for excludedtags params
    - `included_tags_mode::String`: "AND" or "OR" mode for includedtags params
    - `status::Vector{String}`: search for specific statuses ("ongoing", "completed", "hiatus", "cancelled")
    - `original_language::Vector{String}`: search for specific original languages
    - `demographic::String`: search for specific demographics ("shounen", "shoujo", "josei", "seinen", "none")
    - `ids::Vector{String}`: search for specific manga ids
    - `content_rating::Vector{String}`: search for specific ratings ("safe", "suggestive", "erotica", "pornographic")
    - `created_at_since::String`: search for mangas created after a specific year
    - `updated_at_since::String`: search for mangas updated after a specific year
    """
    search(; kwargs...) = search(Dict(fix_query_key(k, v) => fix_query_value(v) for (k, v) in kwargs))
    search(query_params::Dict) = map(x -> Manga(x["data"]), JSON.parse(HTTP.request("GET", URIs.URI(scheme="https", host="api.mangadex.org", path="/manga", query=query_params)))["results"])

    for manga in search(includedTags=tag.(["Genderswap"]), title="gender") 
        println(manga.title.en)
    end
end