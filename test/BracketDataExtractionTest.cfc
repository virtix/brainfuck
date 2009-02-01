
<cfcomponent output="false" extends="BrainfuckBracketTest">
<cfscript>


function $houldReturnTheSameArrayAltered(){
    var s = '+++++++++++++[>+++++<-]>.';
    var bytes = s.getBytes();
    var l = createObject('java','java.util.ArrayList').init();
    var sys = createObject('java','java.lang.System');
    var lid = sys.identityhashCode(l);
    var start = 23;

    for(i=1; i <= len(bytes); i++){
        l.add(bytes[i]);
    }

    debug( l.getClass().getName() );
    debug(sys.identityhashCode(l));
    debug(l);

    bm.refactorArrayReference(l,start);

    debug(sys.identityhashCode(l));
    debug(l);
    assertEquals(lid,sys.identityhashCode(l));
    assertEquals(2,l.size());
}



function $_100(){
   bytes = bm.extract(_100.getBytes(),1,28);
   s =  bm.convertBytesToBrainfuck( bytes );
   debug( s );
}


//b3 = 'aaaaa[bbb[ccc]]';
function $b3ShouldGetbbbcccAnd2Brackets(){
  var i = 1;
  var actual = '';
  var expected = 'bbb[ccc]';
  var cArray = '123';
  data = 'aaaaa[bbb[ccc]]';
  //6,15 are array positions
  bytes = bm.extract(data.getBytes(),6,15);
  actual = createObject('java','java.lang.String').init( javacast('byte[]',bytes) );
  debug(actual);
  assertEquals(actual,expected);
}


function $convertShouldReturnAStringAfterSendingItAByteArray(){
  var data = 'aaaaa[bbb[ccc]]';
  var s =  bm.convertBytesToBrainfuck( data.getBytes() );
  debug( s );
  assertEquals(data,s);
}



</cfscript>
</cfcomponent>