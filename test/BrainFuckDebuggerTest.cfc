<cfcomponent output="false" extends="mxunit.framework.TestCase">
<cfscript>


  function testInit() {
     assertIsTypeOf( bugger,'brainfuck.BrainfuckDebugger'  );
  }

 function testSetDebug(){
   program =  [1];
   bugger.debug(43,1,program);
   debug(bugger.getDebugString());
 }

 function testPrintDebug(){
   testSetDebug();
   bugger.printDebug();
 }


  function setUp(){
  	raw = '+++++[>+++<-]>.';
    bugger = createObject('component','brainfuck.BrainfuckDebugger').init(raw);
  }

  function tearDown(){

  }


</cfscript>
</cfcomponent>