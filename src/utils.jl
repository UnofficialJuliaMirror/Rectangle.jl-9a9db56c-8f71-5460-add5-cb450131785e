pcTol(::Type{T}) where {T <: Integer}       = zero(T)
pcTol(::Type{T}) where {T <: Rational}      = zero(T)
pcTol(::Type{T}) where {T <: AbstractFloat} = T(1.0e-6)

"""
```
    parallelogram_area(m::Matrix) -> Float64
```
Area of the parallelogram. The matrix is a 2x3 matrix.
"""
function parallelogram_area(m::Matrix{T}) where {T <: Number}
    @assert size(m) == (2, 3) "Invalid triangle."
    v1 = m[:, 2] - m[:, 3]
    v2 = m[:, 3] - m[:, 1]
    v3 = m[:, 1] - m[:, 2]
    v = max(dot(v1, v1), dot(v2, v2), dot(v3, v3))
    
    m = vcat(m, ones(T, (1, 3)))
    d = det(m)

    v*pcTol(T)*pcTol(T) >= d*d && return zero(T)
    return d
end

