<cfcomponent output="false" extends="mxunit.framework.TestCase">
	<cfscript>

  i = 1;

  function convertBytesToArrayList(){
    var s = 'asdasdasdasd';
    var bytes = s.getBytes();
    var l = createObject('java','java.util.ArrayList').init();
    var sys = createObject('java','java.lang.System');

    var lid1 = sys.identityhashCode(l);
    var lid2 = '';

    //l.addAll(bytes);
    for(i=1; i <= len(bytes); i++){
        l.add(bytes[i]);
      }
    dump(l);
    debug( l.getClass().getName() );

    l = echoArrayList(l);
    lid2 = sys.identityhashCode(l);
    debug( l.getClass().getName() );
    assertEquals(lid1,lid2);
    debug( lid2 );

    for(j=1; j <= arrayLen(l); j++){
      debug(l[j]);
    }

  }


//should be private
  function echoArrayList(a){
  	 arrayAppend(a,'added in method');
  	 writeoutput(arrayLen(a));
  	 a[14]=101;
   return a;
  }

  function assertSameTest(){
   var a = [1,2,3,4];
   testArrayIdentify(a,a);
  // assertSame(a,a);

  }


//should be private
function testArrayIdentify(a,b){
	debug( createObject('java','java.lang.System').identityhashCode(a) );
	debug( createObject('java','java.lang.System').identityhashCode(b) );

}

  function testArrayIdentity(){
    var a1 = [1,2,3,4];
    debug( createObject('java','java.lang.System').identityhashCode(a1) );
    a1 = echoArray(a1);
    debug(createObject('java','java.lang.System').identityhashCode(a1));

	}


	function testRecursionArrayScopeIdentity(){
    var a1 = [1,2,3,4];
    debug( createObject('java','java.lang.System').identityhashCode(a1) );
    a1 = recurse(a1);
    debug(createObject('java','java.lang.System').identityhashCode(a1));

	}


  function testChangeArrayListUsingRemove(){
   var a = createObject('java','java.util.ArrayList').init();
   a.add(1);
   a.add(2);
   a.add(3);
   a.add(4);
   changearray(a);
   debug(a);

  }

  function testChangeArrayUsingRemove(){
   var a = [1,2,3,4];
   changearray(a);
   debug(a);

  }
	</cfscript>


<cffunction name="template" access="private">
  <cfscript>

	</cfscript>
</cffunction>


<cffunction name="template" access="private">
  <cfscript>

	</cfscript>
</cffunction>

 <cffunction name="changeArray" access="private">
	 <cfargument name="a2" type="any" />
   <cfset a2.remove(1)>
	 <cfdump var="#arguments#">
 </cffunction>


	<cffunction name="recurse" access="private">
	  <cfargument name="a2" />
	    <cfset var localArray = arguments.a2 />
          <cfset arguments.a2 = echoArray(localArray) />
					<cfset debug( '    > ' & createObject("java","java.lang.System").identityhashCode(localArray) ) />
			<cfif i eq 10>
				<cfreturn false/>
			</cfif>
			<cfset i++ />
      <cfset recurse(localArray) >
      <cfreturn localArray />
	</cffunction>


	<cffunction name="echoArray" access="private">
	  <cfargument name="a" type="array" />
	  <cfset a[1] = 'bbb'>
    <cfreturn a />
	</cffunction>

</cfcomponent>