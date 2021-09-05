struct LocalizedString
    lang_map
end

Base.getindex(x::LocalizedString, key) = return x.lang_map[key]
Base.getproperty(x::LocalizedString, sym::Symbol) = sym == :lang_map ? getfield(x, :lang_map) : x[String(sym)]

