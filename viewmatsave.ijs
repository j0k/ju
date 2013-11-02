require 'graphics/bmp graphics/gl2 viewmat'

coclass 'jviewmat'

coinsert 'jgtk jgl2 jni jaresu viewmat'

viewmatsave=: 3 : 0
	'~temp/viewmat.bmp' viewmatsave y
:
	GUI =: 0[ GUIold =. GUI   NB. GUI=: not GUI=.
	x =. '' [ filename =. x
	a=. '' conew 'jviewmat'
	xx__a=: x [ yy__a=: y
	empty vmrun__a ''
	(no_gui_bmp__a'') writebmp jpath filename
	if. (UNAME-:'Android') *. 0=isatty 0 do.
		android_exec_host 'android.intent.action.VIEW';('file://',jpath filename);'image/bitmap'
	end.
	res=.destroy__a ''
	res [ GUI =: GUIold	
	
)
NB. echo "J0kutils /home/gits/j0k/ju" >> ~/j64-701/system/config/folders.cfg
NB. load '~J0kutils/viewmatsave.ijs'
NB. '/tmp/some.bmp' viematsave =/~ i.10

viewmatsave_z_=: viewmatsave_jviewmat_
