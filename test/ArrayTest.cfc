<cfcomponent output="false" extends="mxunit.framework.TestCase">
<cfscript>





  function testArrayList() {
    var l = createObject('java','java.util.ArrayList');
     l.add(1);
     l.add(2);
     l.add(3);
     debug(l);
     change(l);
     debug(l);
     //assertEquals(2,2);
  }



  function setUp(){

  }

  function tearDown(){

  }


</cfscript>
<cffunction name="change" access="private">
  <cfargument name="a">
  <cfset a.remove(1)>
</cffunction>
</cfcomponent>