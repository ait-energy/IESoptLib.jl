module IESoptLib

const _PATH_LIB = normpath(dirname(@__FILE__))
export get_path, get_filename

"""
    get_path()

Get the path of a given asset type.

# Arguments
- `asset_type::Symbol`: The type of asset, possible values are `:examples`, `:addons`, and `:templates`.

# Returns
- `String`: The path of the folder containing all assets of the given type.

# Example
```julia
get_path(:examples)
```
"""
function get_path(asset_type::Symbol)::String
    if asset_type == :examples
        return abspath(_PATH_LIB, "examples")
    elseif asset_type == :addons
        return abspath(_PATH_LIB, "addons")
    elseif asset_type == :templates
        return abspath(_PATH_LIB, "templates")
    end

    throw(ArgumentError("Invalid asset type: $asset_type"))
end

function get_filename(type::Symbol, name::String)::String
    filename = begin
        if type == :example
            abspath(get_path(:examples), "$(name).iesopt.yaml")
        elseif type == :addon
            abspath(get_path(:addons), "$(name).jl")
        elseif type == :template
            abspath(get_path(:templates), "$(name).iesopt.template.yaml")
        else
            throw(ArgumentError("Invalid asset type: $type"))
        end
    end

    isfile(filename) || throw(ArgumentError("File not found: $filename"))
    return filename
end

end
