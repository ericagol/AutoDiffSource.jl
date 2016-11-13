const δceil_const = true
const δfloor_const = true
const δrand_const = true
const δrandn_const = true
const δround_const = true
const δsign_const = true
const δsize_const = true
const δsrand_const = true
const δtrunc_const = true
const δzeros_const = true
const δones_const = true
δzeros(x::AbstractArray) = zeros(x)
δzeros{T}(x::T) = 0::T
safediv{T}(x::T, y) = y == 0 ? 0::T : x / y
δabs(x) = (abs(x), z->z*sign(x))
δacos(x) = (acos(x), z->-z/sqrt(1-x*x))
δasin(x) = (asin(x), z->z/sqrt(1-x*x))
δatan(x) = (atan(x), z->z/(1+x*x))
δcos(x) = (cos(x), z->-z*sin(x))
δcosh(x) = (cosh(x), z->z*sinh(x))
δdivide(x::AbstractArray, y::AbstractFloat) = (t = x/y; (t, z->(z/y, -sum(z.*t./y))))
δdivide(x::AbstractFloat, y::AbstractFloat) = (t = x/y; (t, z->(z/y, -z*t/y)))
δdivide_const1(x, y) = (t = x/y; (t, z->(-z*t/y)))
δdivide_const2(x, y) = (x/y, z->(z/y))
δdot(x, y) = (dot(x, y), z->(z.*y, z.*x))
δdot_abs(x) = (abs.(x), z->z.*sign.(x))
δdot_acos(x) = (acos.(x), z->-z./sqrt.(1-x.*x))
δdot_asin(x) = (asin.(x), z->z./sqrt.(1-x.*x))
δdot_atan(x) = (atan.(x), z->z./(1+x.*x))
δdot_cos(x) = (cos.(x), z->-z.*sin.(x))
δdot_cosh(x) = (cosh.(x), z->z.*sinh.(x))
δdot_divide(x::AbstractArray, y::AbstractFloat) = (t = x./y; (t, z->(z./y, -sum(z.*t)/y)))
δdot_divide(x::AbstractFloat, y::AbstractArray) = (t = x./y; (t, z->(sum(z./y), -z.*t./y)))
δdot_divide(x::AbstractMatrix, y::AbstractVector) = (t = x./y; (t, z->(z./y, -sum(z.*t./y, 2))))
δdot_divide(x::AbstractVector, y::AbstractMatrix) = (t = x./y; (t, z->(sum(z./y, 2), -z.*t./y)))
δdot_divide_const1(x, y) = (t = x./y; (t, z->(-z.*t./y)))
δdot_divide_const2(x, y) = (x./y, z->(z./y))
δdot_divide{T}(x::T, y::T) = (t = x./y; (t, z->(z./y, -z.*t./y)))
δdot_erf(x) = (erf.(x), y->y.*2/sqrt(π).*exp.(-x.*x))
δdot_erfc(x) = (erfc.(x), y->-y.*2/sqrt(π).*exp.(-x.*x))
δdot_exp(x) = (t = exp.(x); (t, z->z.*t))
δdot_expm1(x) = (t = expm1.(x); (t, z->z.*(1 + t)))
δdot_gamma(x) = (t=gamma.(x); (t, y->y.*polygamma.(0,x).*t))
δdot_lgamma(x) = (lgamma.(x), y->y.*polygamma.(0,x))
δdot_log(x) = (log.(x), z->z./x)
δdot_log1p(x) = (log1p.(x), z->z./(1 + x))
δdot_max_const1(x, y) = (max.(x, y), z->z.*(x.<y))
δdot_max_const2(x, y) = (max.(x, y), z->z.*(x.>y))
δdot_max{T}(x::T, y::T) = (max.(x, y), z->(z.*(x.>y),z.*(x.<y)))
δdot_min_const1(x, y) = (min.(x, y), z->z.*(x.>y))
δdot_min_const2(x, y) = (min.(x, y), z->z.*(x.<y))
δdot_minus(x::AbstractArray, y::AbstractFloat) = (x.-y, z->(z, -sum(z)))
δdot_minus(x::AbstractFloat, y::AbstractArray) = (x.-y, z->(sum(z), -z))
δdot_minus(x::AbstractMatrix, y::AbstractVector) = (x.-y, z->(z, -sum(z, 2)))
δdot_minus(x::AbstractVector, y::AbstractMatrix) = (x.-y, z->(sum(z, 2), -z))
δdot_minus_const1(x, y) = (x.-y, z->-z)
δdot_minus_const2(x, y) = (x.-y, z->z)
δdot_minus{T}(x::T, y::T) = (x.-y, z->(z, -z))
δdot_min{T}(x::T, y::T) = (min.(x, y), z->(z.*(x.<y),z.*(x.>y)))
δdot_mod2pi(x::AbstractArray) = (mod2pi.(x), y->y)
δdot_plus(x::AbstractArray, y::AbstractFloat) = (x.+y, z->(z, sum(z)))
δdot_plus(x::AbstractFloat, y::AbstractArray) = (x.+y, z->(sum(z), z))
δdot_plus(x::AbstractMatrix, y::AbstractVector) = (x.+y, z->(z, sum(z, 2)))
δdot_plus(x::AbstractVector, y::AbstractMatrix) = (x.+y, z->(sum(z, 2), z))
δdot_plus_const1(x, y) = (x.+y, z->z)
δdot_plus_const2(x, y) = (x.+y, z->z)
δdot_plus{T}(x::T, y::T) = (x.+y, z->(z, z))
δdot_power(x::AbstractArray, y::AbstractFloat) = (t = x.^y; (t, z->(safediv.(z.*y.*t, x), sum(z.*t.*log.(x)))))
δdot_power(x::AbstractFloat, y::AbstractArray) = (t = x.^y; (t, z->(safediv(sum(z.*y.*t), x), z.*t.*log.(x))))
δdot_power(x::AbstractMatrix, y::AbstractVector) = (t = x.^y; (t, z->(safediv.(z.*y.*t, x), sum(z.*t.*log.(x), 2))))
δdot_power(x::AbstractVector, y::AbstractMatrix) = (t = x.^y; (t, z->(sum(safediv.(z.*y.*t, x), 2), z.*t.*log.(x))))
δdot_power_const1(x, y) = (t = x.^y; (t, z->z.*t.*log(x)))
δdot_power_const2(x, y) = (t = x.^y; (t, z-> y == 2 ? z.*2x : safediv.(z.*y.*t, x)))
δdot_power{T}(x::T, y::T) = (t = x.^y; (t, z->(safediv.(z.*y.*t, x), z.*t.*log.(x))))
δdot_sin(x) = (sin.(x), z->z.*cos.(x))
δdot_sinh(x) = (sinh.(x), z->z.*cosh.(x))
δdot_sqrt(x) = (t = sqrt.(x); (t, z->0.5*z./t))
δdot_tan(x) = (t = tan.(x); (t, z->z.*(1+t.*t)))
δdot_tanh(x) = (t = tanh.(x); (t, z->z.*(1-t.*t)))
δdot_times(x::AbstractArray, y::AbstractFloat) = (x.*y, z->(z.*y, sum(z.*x)))
δdot_times(x::AbstractFloat, y::AbstractArray) = (x.*y, z->(sum(z.*y), z.*x))
δdot_times(x::AbstractMatrix, y::AbstractVector) = (x.*y, z->(z.*y, sum(z.*x, 2)))
δdot_times(x::AbstractVector, y::AbstractMatrix) = (x.*y, z->(sum(z.*y, 2), z.*x))
δdot_times_const1(x, y) = (x.*y, z->(z.*x))
δdot_times_const2(x, y) = (x.*y, z->(z.*y))
δdot_times{T}(x::T, y::T) = (x.*y, z->(z.*y, z.*x))
δerf(x) = (erf(x), y->y*2/sqrt(π)*exp(-x*x))
δerfc(x) = (erfc(x), y->-y*2/sqrt(π)*exp(-x*x))
δexp(x) = (t = exp(x); (t, z->z*t))
δexpm1(x) = (t = expm1(x); (t, z->z*(1 + t)))
δfanout(x) = (x..., (z...) -> z)
δgamma(x) = (t=gamma(x); (t, y->y*polygamma(0,x)*t))
δlgamma(x) = (lgamma(x), y->y*polygamma(0,x))
δlog(x) = (log(x), z->z/x)
δlog1p(x) = (log1p(x), z->z/(1 + x))
δmax(x, y) = (max(x, y), z->(z*(x>y),z*(x<y)))
δmax_const1(x, y) = (max(x, y), z->z*(x<y))
δmax_const2(x, y) = (max(x, y), z->z*(x>y))
δmaximum(x) = (t=maximum(x); (t, y->(t.==x).*y))
δmin(x, y) = (min(x, y), z->(z*(x<y),z*(x>y)))
δmin_const1(x, y) = (min(x, y), z->z*(x>y))
δmin_const2(x, y) = (min(x, y), z->z*(x<y))
δminimum(x) = (t=minimum(x); (t, y->(t.==x).*y))
δminus(x) = (-x, z->-z)
δminus(x::AbstractArray, y::AbstractFloat) = (x-y, z->(z, -sum(z)))
δminus(x::AbstractFloat, y::AbstractArray) = (x-y, z->(sum(z), -z))
δminus_const1(x, y) = (x-y, z->-z)
δminus_const2(x, y) = (x-y, z->z)
δminus{T}(x::T, y::T) = (x-y, z->(z, -z))
δmod2pi(x::AbstractFloat) = (mod2pi(x), y->y)
δplus(x::AbstractArray, y::AbstractFloat) = (x+y, z->(z, sum(z)))
δplus(x::AbstractFloat, y::AbstractArray) = (x+y, z->(sum(z), z))
δplus_const1(x, y) = (x+y, z->z)
δplus_const2(x, y) = (x+y, z->z)
δplus{T}(x::T, y::T) = (x+y, z->(z, z))
δpower(x::AbstractFloat, y::AbstractFloat) = (t = x^y; (t, z->(safediv(z*y*t, x), z*t*log(x))))
δpower_const1(x, y) = (t = x^y; (t, z->z*t*log(x)))
δpower_const2(x, y) = (t = x^y; (t, z->safediv(z*y*t, x)))
δsin(x) = (sin(x), z->z*cos(x))
δsinh(x) = (sinh(x), z->z*cosh(x))
δsqrt(x) = (t = sqrt(x); (t, z->0.5*z/t))
δsum(x) = (t = size(x); (sum(x), z->fill(z, t)))
δsum(x::AbstractFloat) = (x, z->z)
δtan(x) = (t = tan(x); (t, z->z*(1+t*t)))
δtanh(x) = (t = tanh(x); (t, z->z*(1-t*t)))
δtimes(x::AbstractArray, y::AbstractArray) = (x*y, z->(z*y', x'*z))
δtimes(x::AbstractArray, y::AbstractFloat) = (x*y, z->(z.*y, sum(z.*x)))
δtimes(x::AbstractFloat, y::AbstractArray) = (x*y, z->(sum(z.*y), z.*x))
δtimes(x::AbstractFloat, y::AbstractFloat) = (x*y, z->(z*y, z*x))
δtimes_const1(x, y) = (x*y, z->(x'*z))
δtimes_const1(x, y::AbstractFloat) = (x*y, z->sum(x'*z))
δtimes_const2(x, y) = (x*y, z->(z*y'))
δtimes_const2(x::AbstractFloat, y) = (x*y, z->sum(z*y'))
δtranspose(x) = (x', y->y')
