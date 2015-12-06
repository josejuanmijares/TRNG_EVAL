import Base.Random.rand

abstract AbstractRNG

type SuperJuice <: AbstractRNG
	value::Int64
	
	function SuperJuice()
		return SuperJuice(1)
	end
	function SuperJuice(x::Int64)
		this = new()
		this.value = x
		return this
	end 
end

function rand(rng::SuperJuice,dims::Int64)
	rng.value = dims
	return ones(dims)
end