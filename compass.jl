### A Pluto.jl notebook ###
# v0.11.14

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    quote
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : missing
        el
    end
end

# ╔═╡ cf904956-fdb1-11ea-2756-231b77b2c778
begin
	using Pkg
	
	Pkg.add("PlutoUI")
	 
	using PlutoUI 
end

# ╔═╡ 2df32880-fdb0-11ea-3dc8-5304abc5a15d
function point_from_bearing(bearing°::Number, letters_lim::Int)
# Returns a compass point from a bearing given in degrees
    if letters_lim < 1  ||  letters_lim > 4
        throw("letters_lim must be between 1 and 4 inclusively.")
    end

    # Take care of bearings greater than 360° or less than zero.................
    b = bearing° % 360
    if b < 0;    b += 360; end
    #...........................................................................



    points1 = ['N', 'E', 'S', 'W']

    points2 = ["N ", "NE", "E ", "SE", "S ", "SW", "W ", "NW"]

    points3 = [" N ", "NNE", "NE ", "ENE", " E ", "ESE", "SE ", "SSE",
               " S ", "SSW", "SW ", "WSW", " W ", "WNW", "NW ", "NNW"]

    points4 = [" N  ", "NbE ", "NNE ", "NEbN", " NE ", "NEbE", "ENE ", "EbN ",
               " E  ", "EbS ", "ESE ", "SEbE", " SE ", "SEbS", "SSE ", "SbE ",
               " S  ", "SbW ", "SSW ", "SWbS", " SW ", "SWbW", "WSW ", "WbS ",
               " W  ", "WbN ", "WNW ", "NWbW", " NW ", "NWbN", "NNW ", "NbW "]

    points = [points1, points2, points3, points4]

    point_span° = 360 / 2^(letters_lim + 1)

    if b ≥ 360 - point_span° / 2  ||  b < point_span° / 2
        point = points[letters_lim][1]
    else
        i = convert(Int64, floor((bearing° / point_span°) + 1.5))
        point = points[letters_lim][i]
    end


    point
end

# ╔═╡ 3b723604-fdb0-11ea-102d-bd288e15047c
begin
	
	NF_deg = @bind bearing° html"<input type=number min=0 max=360 step=1 value=57>" 
	NF_lim = @bind letters_lim html"<input type=number min=1 max=4 step=1 value=4>"
	
	 
	md"""
	
	bearing°     : $(NF_deg)
	letters limit: $(NF_lim)
	"""
end
 

# ╔═╡ ef98c9e2-fdb1-11ea-36d6-4b3f1b1ec65b
@bind output TextField((4,1), point_from_bearing(bearing°, letters_lim))

# ╔═╡ 8bb6790c-fdc9-11ea-2eb9-4104025acd4f
∑ = sum

# ╔═╡ 279e2bec-fdc9-11ea-2bfc-efd586679426
mag(a) = √∑(a.^2)

# ╔═╡ 64808046-fdb5-11ea-38f6-bb08b0a10f6f
mag([3,4,12,13])

# ╔═╡ 3d9ad3be-fdc9-11ea-292e-4d96c559b522
dist(a, b) = √∑((a-b).^2) #😎

# ╔═╡ 50ca4fa0-fdc9-11ea-2879-d7be38a8aef1
dist([2,3,5],[7,11,13])

# ╔═╡ f2e349ba-fdcc-11ea-0e36-134373205a12
function collatz(seed)
	next(x) = x % 2 == 0    ?    x ÷ 2    :    3x + 1
	vals = [seed]
	while last(vals) !== 1
		push!(vals, next(last(vals))) 
	end
	
	vals
end

# ╔═╡ cac67a5e-fdce-11ea-0880-7dde7fd9efe6
collatz(1337)

# ╔═╡ Cell order:
# ╟─cf904956-fdb1-11ea-2756-231b77b2c778
# ╟─2df32880-fdb0-11ea-3dc8-5304abc5a15d
# ╟─3b723604-fdb0-11ea-102d-bd288e15047c
# ╟─ef98c9e2-fdb1-11ea-36d6-4b3f1b1ec65b
# ╠═8bb6790c-fdc9-11ea-2eb9-4104025acd4f
# ╠═279e2bec-fdc9-11ea-2bfc-efd586679426
# ╠═64808046-fdb5-11ea-38f6-bb08b0a10f6f
# ╠═3d9ad3be-fdc9-11ea-292e-4d96c559b522
# ╠═50ca4fa0-fdc9-11ea-2879-d7be38a8aef1
# ╠═f2e349ba-fdcc-11ea-0e36-134373205a12
# ╠═cac67a5e-fdce-11ea-0880-7dde7fd9efe6
