<cfcomponent extends="mxunit.framework.TestCase">
    <!--- Contains shared data --->
    <cfinclude template="brainfuck-data.cfm">

<cfscript>
  
  function testExecReturnsArray(){
    var actual = bf.exec(urlencodedformat(hw));
    debug(actual);
  }
    
  function collectShouldAddBytes(){
    bf.collect(1);
    bf.collect(2);
    bf.collect(3);
    bf.collect(4);
    bf.collect(5);
    debug(bf.getBrainfuckBuffer());
    assertEquals(5, bf.getBrainfuckBuffer().size() );
  }  
  
   function brainfuckBufferShouldHaveAnA(){
    var list = bf.interpret(a);
    var actual = bf.getBrainfuckBuffer();
    debug(actual);
    assertEquals('A',actual[1]);
  }  

 function testURLEncodedInput(){
  s = urlencodedformat(a);
  debug(s);
  bf.exec(urlEncodedBrainfuck=s,debug=true);
  s = urldecode(s);
  debug(s);
  //bf.execute(s);
 }

 function testInitProgramShouldReturnFuckingArrayList(){
   var list = bf.initProgram(a);
   debug(list);
   assertEquals(len(a),arrayLen(list));
 }

 function testInitProgramShouldBeefUpProgram(){
   var list = bf.initProgram(hw);
   debug(list);
   assertEquals(len(hw),arrayLen(list));
 }

 function doSimpleLoop(){
   bf.execute(simple);
 }

  function print127ASCII1Characters(){
    var i = 0;
    for(;i < 128;i++){
     debug(i & ' = ' & chr(i));
    }
  }

  function shouldPrint1A(){
	bf.execute(A);
	bf.printDebug();
  }

  function shouldPrint2As(){
	bf.execute(_2As);
	bf.printDebug();
  }

  function testALoop(){
	bf.execute(A);
	bf.printDebug();
	actual = bf.getBrainfuckBuffer();
	assertEquals('A',actual[1]);
  }

   function testPrint100(){
	bf.execute(_100);
	debug(bf.getBrainfuckBuffer());
	bf.printDebug();
  }

  function testHelloWorld(){
	 bf.interpret(hw);
	 bf.printDebug();
}

  function testHelloWorld2(){
	 bf.interpret(hw2);
	 actual = bf.getBrainfuckBuffer();
	 debug(actual);
	 bf.printDebug();
	 assertTrue( actual.size() ,'empty results?' );
	 assertEquals( '!', actual[12], 'weird results' );
  }

  function testInternalLoopLogic(){
    bf.execute('>+++++<-');
  }

  function testPrintF(){
    bf.execute(F);
  }

  function setUp(){
     bf = createObject('component','brainfuck.Brainfuck').init(debug=true);
  }

  function tearDown(){
   bf = chr(0);
  }
</cfscript>

</cfcomponent>