module myGA4
	using Base.AbstractRNG
	
	export SuperJuice, AbstractRNG
	
	abstract AbstractRNG
	
	type SuperJuice <:AbstractRNG
		function SuperJuice()
			y = cell(8,2)
			y = pmap(long_computation,2^14,8,100,workers())
			ind = findmin(y[:,2])[2]
			return y[ind,1]
		end
	end

	function long_computation(idx, N,kstop)
		x = Array(Float64,N)
		xc = Array(Float64,N)
		xp = Array(Float64,N) 
		ind_c = Array(Int64,N)
		x_score::Float64 =0.0
		xc_score::Float64 =0.0
		xp_score::Float64 =0.0
	
		x = EHEfast_0to1(rand(N),N)
		x_score = evaluate(x,N)
	
		for k =1:kstop
			ind_c = doOrder1X0_2(N)
			xc = copy(x[ind_c])
			xc = doShuffleMutation(xc,N,0.1)
			xc_score = evaluate(xc,N)
			xp = EHEfast_0to1(rand(N),N)
			xp_score = evaluate(xp,N)
			opt = findmin([x_score, xc_score, xp_score])[2]
			if opt == 2
				x = copy(xc)
				x_score = xc_score
			end
			if opt == 3
				x = copy(xp)
				x_score = xp_score
			end
		end
	
		return x, x_score
	end

	function EHEfast_0to1(xin,N)
		ind = sortperm(xin)
		ind2 = zeros(N)
		[ind2[ind[k]] = k for k=1:N]
		binsize = 2
		ratio = convert(Float64, binsize)/convert(Float64, N)
		offset = floor((ind2-1)/binsize)*ratio
		xin = mod(xin,ratio) + offset
		return xin
	end

	function evaluate(S,N)
		No2 = Int64(N/2)
		psd = zeros(Float64,No2+1)
		psd = (1/N)*( abs( fft(S)[1:No2] ) .^2)
		return std(psd)
	end

	function doOrder1X0_2(N)
		p1_ind = shuffle([1:N;])
		p2_ind = shuffle([1:N;])
		childVec_ind = zeros(Int64,N)
		ini_Pt = rand( [1:(N - 1 );]);
		end_Pt = rand( [(ini_Pt + 1):N;]);

		A1 = zeros(Int64, end_Pt-ini_Pt + 1 )
		A1 = p1_ind[ini_Pt:end_Pt]
		A0 = setdiff(p2_ind, A1 )[1:(ini_Pt-1)]
		A2 = setdiff(p2_ind, [A1;A0] )
		childVec_ind = [A0; A1; A2]
		return childVec_ind
	end
	
	function doShuffleMutation(child1, N, prob_mutation)
		if rand() <= prob_mutation
			child1 = shuffle(child1)
		end
		return child1
	end

	function pmap(f, N, M, kstop, myprocs=workers())
		np = nprocs()  # determine the number of processes available
		results = cell(M,2)
		i = 1
		# function to produce the next work item from the queue.
		# in this case it's just an index.
		nextidx() = (idx=i; i+=1; idx)
		@sync begin
		   for p in myprocs
		       if p != myid() || np == 1
		           @async begin
		               while true
		                   idx = nextidx()
		                   if idx > M
		                       break
		                   end
		                   results[idx,1],results[idx,2]  = remotecall_fetch(p, f, idx, N, kstop)
		               end
		           end
		       end
		   end
		end
		return results
	end

end
	
