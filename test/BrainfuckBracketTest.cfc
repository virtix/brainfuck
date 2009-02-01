<cfcomponent output="false" extends="mxunit.framework.TestCase">
<cfinclude template="brainfuck-data.cfm">

<cfscript>
 function setUp(){
    bm = createObject('component','brainfuck.BrainfuckParser');
  }


  function balancedBracketsShouldReturnGreatherThanZero(){
 		 var data = 'asd[asd[]]';
 		 pos = bm.match(data.getBytes());
     debug(pos);
     assertTrue( pos.end-pos.start > 0 );
  }

  function _100ShouldReturn11_20() {
     pos = bm.match(_100.getBytes());
     debug(pos);
     assertEquals(11,pos.start, 'start');
     assertEquals(20,pos.end, 'end');
  }

  function b1ShouldReturn4_8() {
     pos = bm.match(b1.getBytes());
     //debug(pos);
     assertEquals(4,pos.start, 'start');
     assertEquals(8,pos.end, 'end');
  }

  function b2ShouldReturn1_5() {
     pos = bm.match(b2.getBytes());
     //debug(pos);
     assertEquals(1,pos.start, 'start');
     assertEquals(5,pos.end, 'end');
  }

  function b3ShouldReturn6_15() {
     pos = bm.match(b3.getBytes());
     //debug(pos);
     assertEquals(6,pos.start, 'start');
     assertEquals(15,pos.end, 'end');
  }

  function b4ShouldReturn11_28() {
     pos = bm.match(b4.getBytes());
     //debug(pos);
     assertEquals(11,pos.start, 'start');
     assertEquals(28,pos.end, 'end');
  }

  function b5ShouldReturn1_2(){
     pos = bm.match(b5.getBytes());
     //debug(pos);
     assertEquals(1,pos.start, 'start');
     assertEquals(2,pos.end, 'end');
  }

  function b6ShouldReturn6_26(){
     pos = bm.match(b6.getBytes());
     //debug(pos);
     assertEquals(6,pos.start, 'start');
     assertEquals(26,pos.end, 'end');
  }



</cfscript>

</cfcomponent>