coclass 'joboxcyc'

NB. box cyclic
boxcyc =: 4 : 0
       'dx dy' =. (# x), # y
       if. -. dx (*.&:(>&0)) dy do. '' return. end.
       r =. > 0{y
       for_i. i. <: dy do.
       	     f =. (( dx | i){x) `:6
	     r =. r f (> (( dy | >: i){y))
       end.
       r
)
NB. +`* boxcyc ;/ i.5
NB. ┌─┬─┬─┬─┬─┐
NB. │0│1│2│3│4│
NB. └─┴─┴─┴─┴─┘
NB. ((((0 + 1) * 2) + 3) * 4)

NB. Box cyclic Monad First
boxcycMF =: 4 : 0
       'dx dy' =. (<: # x), # y
       if. -. (>:dx) (*.&:(>&0)) dy do. '' return. end.
       f =. ( 0 {x) `:6
       r =. f (> 0{y )
       if. 0 = dx do. r return. end.
       for_i. i. <: dy do.
       	     f =. ((>:  dx | i){x) `:6
	     r =. r f (> (( dy | >: i){y))
       end.
       r
)
NB. +:`+`* boxcycMF ;/ >: i.5
NB. ┌─┬─┬─┬─┬─┐
NB. │1│2│3│4│5│
NB. └─┴─┴─┴─┴─┘
NB. (((((+: 1) + 2) * 3) + 4) * 5)
    

NB. test
test_boxcyc=: 3 : 0
      r =. ''
      r =. r,20 = +`*      boxcyc    ;/ i.5
      r =. r,0  = $ +:`+`* boxcyc    < i.0
      r =. r,1  = +`*      boxcyc    ;/ i.2
      r =. r,2  = +:`+`*   boxcycMF  ;/ >: i.1
      r =. r,80 = +:`+`*   boxcycMF  ;/ >: i.5
      r =. r,0  = $ +:`+`* boxcycMF  < i.0
      r =. r,4  = +:`''    boxcycMF ;/ >: >: i.1
      r =. r,4  = +:`''    boxcycMF ;/ >: >: i.20
      *./ r = 1
)

boxcyc_z_   =:   boxcyc_joboxcyc_
boxcycMF_z_ =: boxcycMF_joboxcyc_