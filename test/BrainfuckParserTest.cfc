<cfcomponent output="false" extends="mxunit.framework.TestCase">
<cfinclude template="brainfuck-data.cfm">

<cfscript>
 function setUp(){
    bm = createObject('component','brainfuck.BrainfuckParser');
  }

   function parseHelloWorld2ShouldNotThrowException(){
    bm.parse(hw2.getBytes());
  }


  function parseHelloWorldShouldNotThrowException(){
    bm.parse(hw.getBytes());
  }

  function complexMatchedBracketsShouldPassParser(){
    bm.parse(b6.getBytes());
  }

  function complexMismatchedBracketsShouldFail(){
   try{
    bm.parse(unbalanced1.getBytes());

    fail('bm.parse(unbalanced1.getBytes()); should have failed');
   }catch(BrainfuckParserException e){
     debug(e);
   }

  }

</cfscript>
</cfcomponent>