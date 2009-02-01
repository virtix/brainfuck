<cfcomponent output="false" extends="mxunit.framework.TestCase">
<cfscript>



  function testRecursino() {
     fail('to do');
  }



  function setUp(){

  }

  function tearDown(){

  }


</cfscript>

	<cffunction name="recurse" access="private">
	  <cfargument name="message" />
     <cfset var foo = 'bar' >
	    <cfset debug(message & ' ' & foo) />
      <cfif i eq 10>
				<cfreturn false/>
			</cfif>
			<cfset i++ />
			<cfset foo = 'barbazoidz'>
			<cfset recurse('recursing #right(foo,i)#') >

	</cffunction>
</cfcomponent>