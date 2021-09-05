abstract type DataObject end 

getid(x::DataObject) = "0"
Base.:(==)(x::DataObject, y::DataObject) = getid(x) == getid(y)