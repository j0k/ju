NB. load '~J0kutils/boxcyc.ijs'

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


cross =: 1 : 0
:
	'funcs b' =. x;<y
	d =. # b		NB. $fs = $b
	select. d	
	case. 0 do.  y return.
	case. 1 do. (({.funcs) `:6 each b ) return.
	case. do. 		NB. d>1
	  w =. <''
	  for_i. i. (#@:> 0{:: b) do.		NB. how to simplify it?
	    w =. w, <(i&{)@:> each y
	  end.
	  w =. }.w
	  w =. funcs u w
	end.  
	w
)
NB. ]a =. < each (<"1) 3 5 $ i.16
NB. ┌───────────┬───────────┬────────────────┐
NB. │┌─────────┐│┌─────────┐│┌──────────────┐│
NB. ││0 1 2 3 4│││5 6 7 8 9│││10 11 12 13 14││
NB. │└─────────┘│└─────────┘│└──────────────┘│
NB. └───────────┴───────────┴────────────────┘

NB. (<@:])`([ , <@:]) boxcycMF cross a
NB. ┌────────┬────────┬────────┬────────┬────────┐
NB. │┌─┬─┬──┐│┌─┬─┬──┐│┌─┬─┬──┐│┌─┬─┬──┐│┌─┬─┬──┐│
NB. ││0│5│10│││1│6│11│││2│7│12│││3│8│13│││4│9│14││
NB. │└─┴─┴──┘│└─┴─┴──┘│└─┴─┴──┘│└─┴─┴──┘│└─┴─┴──┘│
NB. └────────┴────────┴────────┴────────┴────────┘
      
NB. +`* (boxcyc L:1) cross a
NB. ┌──┬──┬───┬───┬───┐
NB. │50│77│108│143│182│
NB. └──┴──┴───┴───┴───┘
      
NB. 0{::a
NB. ┌─────────┐
NB. │0 1 2 3 4│
NB. └─────────┘

NB. +:`'' (boxcyc L:1) cross 0{::a
NB. ┌─────────┐
NB. │0 2 4 6 8│
NB. └─────────┘

NB. {. > 0{::a
NB. 0

NB. >:`'' (boxcyc L:1) cross  {. > 0{::a
NB. ┌─┐
NB. │1│
NB. └─┘

NB. ORIGINAL IDEA
NB. funcs docross boxes 
NB. f1;f2 docross A;B
NB. foreach(f1 a) do ( (f1 a) f2 B[a_index])   

NB. f1;f2;f3 docross A;B;C
NB. foreach(f1 a) 
NB.   do ( foreach ((f1 a) f2 B[A_index]) 
NB.          do (((f1 a) f2 B[A_index]) f3 C[a_index]))