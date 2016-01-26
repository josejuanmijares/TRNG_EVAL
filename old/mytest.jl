include("init_test.jl")

g=RNGTest.wrap(SuperJuice,true,Float64);

@sync println(RNGTest.smarsa_BirthdaySpacings(g, 1, 5000000, 0, 1073741824, 2, 1))
g=RNGTest.wrap(SuperJuice,true,Float64);
@sync println(RNGTest.sknuth_Collision(g, 1, 5000000, 0, 65536, 2))
#@sync println(RNGTest.sknuth_Gap(g, 1, 200000, 22, 0.0, .00390625))
#@sync println(RNGTest.sknuth_SimpPoker(g, 1, 400000, 24, 64, 64))
#@sync println(RNGTest.sknuth_CouponCollector(g, 1, 500000, 26, 16))
#@sync println(RNGTest.sknuth_MaxOft(g, 1, 2000000, 0, 100000, 6))
#@sync println(RNGTest.svaria_WeightDistrib(g, 1, 200000, 27, 256, 0.0, 0.125))
#@sync println(RNGTest.smarsa_MatrixRank(g, 1, 20000, 20, 10, 60, 60))
#@sync println(RNGTest.sstring_HammingIndep(g, 1, 500000, 20, 10, 300, 0)[:Mean])
#@sync println(RNGTest.swalk_RandomWalk1(g, 1, 1000000, 0, 30, 150, 150))


