
""" 
    PlanetaryArgs

Container holding the planetary arguments of the Nutation Theory. 

!!! note 
    The default constructors skip their computation when neither the 
    [`iers2003a`](@ref) and [`iers2010a`](@ref) models are required. This
    results in a maximum error of about 1.5 mas between 2000 and 2100.

### Fields 
- `λ_Me` -- Mercury's mean heliocentric longitude, in radians. 
- `λ_Ve` -- Venus's mean heliocentric longitude, in radians. 
- `λ_Ea` -- Earth's mean heliocentric longitude, in radians. 
- `λ_Ma` -- Mars's mean heliocentric longitude, in radians. 
- `λ_Ju` -- Jupiter's mean heliocentric longitude, in radians. 
- `λ_Sa` -- Saturn's mean heliocentric longitude, in radians. 
- `λ_Ur` -- Uranus's mean heliocentric longitude, in radians. 
- `λ_Ne` -- Neptune's mean heliocentric longitude, in radians. 
- `pₐ` -- General precession in longitude, in radians. 
"""
struct PlanetaryArgs{T}
    λ_Me::T
    λ_Ve::T
    λ_Ea::T
    λ_Ma::T
    λ_Ju::T
    λ_Sa::T
    λ_Ur::T
    λ_Ne::T
    pₐ::T 
end

function PlanetaryArgs(m::IERSAModels, t::Number)

    PlanetaryArgs(
        pa_mercury(m, t),
        pa_venus(m, t),
        pa_earth(m, t),
        pa_mars(m, t),
        pa_jupiter(m, t),
        pa_saturn(m, t),
        pa_uranus(m, t),
        pa_neptune(m, t),
        pa_precession(m, t)
    )

end 

function PlanetaryArgs(::IERSModel, ::Number)
    PlanetaryArgs(0, 0, 0, 0, 0, 0, 0, 0, 0)
end


"""
	pa_mercury(m::IERSModel, t::Number) 

Return the mean heliocentric longitude of Mercury in radians, at time `t` expressed in `TDB` 
Julian centuries since `J2000`. 

!!! warning 
    This function has not been implemented for the IERS 1996 conventions.

### References 
- IERS Technical Note No. [21](https://www.iers.org/IERS/EN/Publications/TechnicalNotes/tn21.html)
- IERS Technical Note No. [36](https://www.iers.org/IERS/EN/Publications/TechnicalNotes/tn36.html) 
- [ERFA](https://github.com/liberfa/erfa/blob/master/src/fame03.c) software library
"""
function pa_mercury(::IERSModel, t::Number)
    return mod2pi(@evalpoly(t, 4.402608842, 2608.7903141574))
end

function pa_mercury(::IERS1996, ::Number)
    throw(
        ErrorException(
            "The mean heliocentric longitude of Mercury was not defined"*
            " in the 1996 Conventions."
        )
    )
end


"""
	pa_venus(m::IERSModel, t::Number) 

Return the mean heliocentric longitude of Venus in radians, at time `t` expressed in `TDB` 
Julian centuries since `J2000`. 

### References 
- IERS Technical Note No. [21](https://www.iers.org/IERS/EN/Publications/TechnicalNotes/tn21.html)
- IERS Technical Note No. [36](https://www.iers.org/IERS/EN/Publications/TechnicalNotes/tn36.html) 
- [ERFA](https://github.com/liberfa/erfa/blob/master/src/fave03.c) software library
"""
function pa_venus(::IERSModel, t::Number)
    return mod2pi(@evalpoly(t, 3.176146697, 1021.3285546211))
end

function pa_venus(::IERS1996, t::Number)
    return mod2pi(deg2rad(@evalpoly(181.979800853, 58517.8156748)))
end


"""
	pa_earth(m::IERSModel, t::Number) 

Return the mean heliocentric longitude of Earth in radians, at time `t` expressed in `TDB` 
Julian centuries since `J2000`. 

### References 
- IERS Technical Note No. [21](https://www.iers.org/IERS/EN/Publications/TechnicalNotes/tn21.html)
- IERS Technical Note No. [36](https://www.iers.org/IERS/EN/Publications/TechnicalNotes/tn36.html) 
- [ERFA](https://github.com/liberfa/erfa/blob/master/src/fae03.c) software library
"""
function pa_earth(::IERSModel, t::Number)
    return mod2pi(@evalpoly(t, 1.753470314, 628.3075849991))
end

function pa_earth(::IERS1996, t::Number)
    return mod2pi(deg2rad(@evalpoly(100.466448494, 35999.3728521)))
end


"""
	pa_mars(m::IERSModel, t::Number) 

Return the mean heliocentric longitude of Mars in radians, at time `t` expressed in `TDB` 
Julian centuries since `J2000`. 

### References 
- IERS Technical Note No. [21](https://www.iers.org/IERS/EN/Publications/TechnicalNotes/tn21.html)
- IERS Technical Note No. [36](https://www.iers.org/IERS/EN/Publications/TechnicalNotes/tn36.html) 
- [ERFA](https://github.com/liberfa/erfa/blob/master/src/fama03.c) software library
"""
function pa_mars(::IERSModel, t::Number)
    return mod2pi(@evalpoly(t, 6.203480913, 334.0612426700))
end

function pa_mars(::IERS1996, t::Number)
    return mod2pi(deg2rad(@evalpoly(t, 355.433274605, 19140.299314)))
end


"""
	pa_jupiter(m::IERSModel, t::Number) 

Return the mean heliocentric longitude of Jupiter in radians, at time `t` expressed in `TDB`
Julian centuries since `J2000`. 

### References 
- IERS Technical Note No. [21](https://www.iers.org/IERS/EN/Publications/TechnicalNotes/tn21.html)
- IERS Technical Note No. [36](https://www.iers.org/IERS/EN/Publications/TechnicalNotes/tn36.html) 
- [ERFA](https://github.com/liberfa/erfa/blob/master/src/faju03.c) software library
"""
function pa_jupiter(::IERSModel, t::Number)
    return mod2pi(@evalpoly(t, 0.599546497, 52.9690962641))
end

function pa_jupiter(::IERS1996, t::Number)
    return mod2pi(deg2rad(@evalpoly(t, 34.3514839, 3034.90567464)))
end


"""
	pa_saturn(m::IERSModel, t::Number) 

Return the mean heliocentric longitude of Saturn in radians, at time `t` expressed in `TDB` 
Julian centuries since `J2000`. 

### References 
- IERS Technical Note No. [21](https://www.iers.org/IERS/EN/Publications/TechnicalNotes/tn21.html)
- IERS Technical Note No. [36](https://www.iers.org/IERS/EN/Publications/TechnicalNotes/tn36.html) 
- [ERFA](https://github.com/liberfa/erfa/blob/master/src/fasa03.c) software library
"""
function pa_saturn(::IERSModel, t::Number)
    return mod2pi(@evalpoly(t, 0.874016757, 21.3299104960))
end

function pa_saturn(::IERS1996, t::Number)
    return mod2pi(deg2rad(@evalpoly(t, 50.0774713998, 1222.11379404)))
end


"""
	pa_uranus(m::IERSModel, t::Number) 

Return the mean heliocentric longitude of Uranus in radians, at time `t` expressed in `TDB` 
Julian centuries since `J2000`. 

!!! warning 
    This function has not been implemented for the IERS 1996 conventions.

### References 
- IERS Technical Note No. [21](https://www.iers.org/IERS/EN/Publications/TechnicalNotes/tn21.html)
- IERS Technical Note No. [36](https://www.iers.org/IERS/EN/Publications/TechnicalNotes/tn36.html) 
- [ERFA](https://github.com/liberfa/erfa/blob/master/src/faur03.c) software library
"""
function pa_uranus(::IERSModel, t::Number)
    return mod2pi(@evalpoly(t, 5.481293872, 7.4781598567))
end

function pa_uranus(::IERS1996, ::Number)
    throw(
        ErrorException(
            "The mean heliocentric longitude of Uranus was not defined"*
            " in the 1996 Conventions."
        )
    )
end


"""
	pa_neptune(m::IERSModel, t::Number) 

Return the mean heliocentric longitude of Neptune in radians, at time `t` expressed in `TDB` 
Julian centuries since `J2000`. 

!!! warning 
    This function has not been implemented for the IERS 1996 conventions.

### References 
- IERS Technical Note No. [21](https://www.iers.org/IERS/EN/Publications/TechnicalNotes/tn21.html)
- IERS Technical Note No. [36](https://www.iers.org/IERS/EN/Publications/TechnicalNotes/tn36.html) 
- [ERFA](https://github.com/liberfa/erfa/blob/master/src/fane03.c) software library
"""
function pa_neptune(::IERSModel, t::Number)
    return mod2pi(@evalpoly(t, 5.311886287, 3.8133035638))
end

function pa_neptune(::IERS1996, ::Number)
    throw(
        ErrorException(
            "The mean heliocentric longitude of Neptune was not defined"*
            " in the 1996 Conventions."
        )
    )
end


"""
  	pa_precession(m::IERSModel, t::Number) 

Return the general accumulated precession in longitude `pₐ` in radians, at time `t` 
expressed in `TDB` Julian centuries since `J2000`. 

### References 
- IERS Technical Note No. [21](https://www.iers.org/IERS/EN/Publications/TechnicalNotes/tn21.html)
- IERS Technical Note No. [36](https://www.iers.org/IERS/EN/Publications/TechnicalNotes/tn36.html) 
- [ERFA](https://github.com/liberfa/erfa/blob/master/src/fapa03.c) software library
"""
function pa_precession(::IERSModel, t::Number)
    return mod2pi(@evalpoly(t, 0, 0.024381750, 0.00000538691))
end

function pa_precession(::IERS1996, t::Number)
    return mod2pi(deg2rad(@evalpoly(t, 0, 1.39697137214, 0.0003086)))
end
