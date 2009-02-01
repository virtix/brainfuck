<cfscript>

  a = [ { key = "a", unchanged = "same" } ];
  dump( var=createObject('java','java.lang.System').identityhashcode(a) );
  dump(var=a);

	function foo(a) {
	 a[1].key = "bar";
	 dump( var=createObject('java','java.lang.System').identityhashcode(a) );
	 dump(var=a);
	 dump( var=createObject('java','java.lang.System').identityhashcode(variables.a) );
	 dump(var=variables.a);
	 return a;
	}

  a = foo(a);
  dump( var=createObject('java','java.lang.System').identityhashcode(a) );
	dump(var=a);

/*a = [ { key = "a" } ];
	function foo() {
		return a;
	}

	b = foo();

	arrayAppend(b,"new");
	dump(var=a);
	dump(var=b);

	arrayAppend(foo(),"stuff");
	dump(var=a);
	dump(var=b);
dump( var=createObject('java','java.lang.System').identityhashCode(a) );

*/
</cfscript>


<cffunction name="dump">
 <cfdump var="#arguments.var#">
</cffunction>