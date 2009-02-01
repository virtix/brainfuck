<cfcomponent extends="mxunit.framework.TestCase">
    <!--- Contains shared data --->
    <cfinclude template="brainfuck-data.cfm">

<cfscript>


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
  }

   function testPrint100(){
	bf.execute(_100);
	bf.printDebug();
  }

  function testHelloWorld(){
	 bf.execute(hw);
	 bf.printDebug();
}

  function testHelloWorld2(){
	 bf.execute(hw2);
	 bf.printDebug();
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