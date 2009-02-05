<cfcomponent output="true">
<cfsetting showdebugoutput="false">

<!---
   Remote entry point. Still need to address debug output. Hmmmm...
	 Debug is an array. Maybe give remote json access to the debug array.
 --->
<cffunction name="exec" access="remote" output="true" returntype="array" returnformat="json">
	<cfargument name="urlEncodedBrainfuck" />
	<cfargument name="debug" required="false" default="false" />
  <cfscript>
	 var fuckit = arguments.urlEncodedBrainfuck;
	 var error = [];
	 try{
	 	setDebug(debug);
	  execute(fuckit);
	  brainFuckBuffer.add(getDebugAsString());
	  logit('string value after interpretation: ' & stringValue());
	  return brainFuckBuffer;
	 }
	 catch(any e){
	  error[1] = e.getType();
	  error[2] = e.getMessage();
	  error[3] = e.getDetail();
	  error[4] = 'Check Brainfuck log for details';
	  return error;
	 }

	</cfscript>
</cffunction>


<cffunction name="getDebugAsString" access="remote" returntype="string">
	<cfset var debugHTML = '' />
	<cfif !debugFlag>
	 <cfset debugHTML = '<p><strong>Warning</strong>: Looks like setDebug() is false. Set it to true to capture debug data.</p>' />
	 <cfreturn debugHTML />
	</cfif>
  <cfsavecontent variable="debugHTML">
   <cfset brainBugger.printDebug() />
	</cfsavecontent>
	<cfreturn debugHTML />
</cffunction>


<cffunction name="getDebugAsArray" access="remote" returntype="Array" returnformat="json">
  <cfset var debugArray = [] />
	<cfset debugArray.add(getDebugAsString()) />
	<cfreturn debugArray />
</cffunction>

<cffunction name="logit">
 <cfargument name="message">
 <cflog application="true" type="information" text="#message#">
</cffunction>


  <cfscript>
  //Instance members
     raw = '';
     program = [];
     brainFuckBuffer = []; //results cache
     pc = 1;
     debugFlag = false;
     isInitialized =  false;
     outputFormat = 'text';
     parser = createObject('component','BrainfuckParser');
     brainBugger = createObject('component','BrainfuckDebugger');
     guard = 0;
     MAX_RECURSION_ATTEMPTS = 2048;

  function init(debug){
    setDebug(debug);
    return this;
  }

  //Main entry point. execute() now just collects
  function interpret(code){
    execute(code);
    print();
  }

  function execute(bytes){
		var byte =  chr(0);
		var pos = {};
		var tempBytes = [];
		var i = 1;

    if(guard++ > MAX_RECURSION_ATTEMPTS) __throw('Possible Infinite Recursion Caught','Recursion iterations exceeded #MAX_RECURSION_ATTEMPTS#. You can increase the MAX_RECURSION_ATTEMPTS in Brainfuck.cfc.');

   if(!isInitialized) {
      bytes = initProgram(bytes);
    }

   for(i=1; i <=  arrayLen(bytes); i++){
      byte = bytes[i];
      if (debugFlag) brainBugger.debug(byte,pc,program);

/*--------------------------------------------------------------------
 Each byte is represented by the following ASCII decimal values
	 + = 43
	 - = 45
	 > = 62
	 < = 60
	 [ = 91
	 ] = 93
	 , = 44 --ignored because we're on the web not in stdout
	 . = 46
--------------------------------------------------------------------*/

     switch(byte){
       case 60: //<
        pc--;
        if(pc < 0) pc = 0;
       break;

       case 62: //>
        pc++;
       break;

       case 43: //+
          program[pc]++;
       break;

       case 45: //-
          program[pc]--;
       break;

       case 46: // .
         //writeoutput( chr(program[pc]) );
         collect(program[pc]);
         //to do. collect and 'then' print.
       break;

       case 44: // , : accept input ... ?
       break;

       case 91: //[
          pos = parser.match(bytes);
          tempBytes = parser.extract(bytes, pos.start,pos.end);

          while(program[pc]){
           execute(tempBytes);
          }
          parser.refactorArrayReference(bytes,pos.end);
          execute(bytes);
          return;
          //Still something wrong with the above logic. Shouldn't
          //have to call execute() and return. Should proceed to next
          //loop iteration and use the refactored bytes. But, for some
          //reason, it's failing by hitting the next case 93: ...

       case 93: // ]
         __throw('Unbalanced Brackets.','Should never get here  #i#: #parser.convertBytesToBrainfuck(bytes)#');
       break;

       default: //no worries. we only care about the other stuff
       break;

      }//end swicth

    }//end for

  }//end execute


 //do only once
  function initProgram(code){
    var i = 1;
    var temp = code.getBytes();
    var bytes = createObject('java','java.util.ArrayList').init();
    raw = arguments.code;
    parser.parse(bytes);
    if(debugFlag){
     brainBugger.init(code);
    }
    if(!isInitialized){
      for(i=1; i <= arrayLen(temp); i++){
        program.add(0);
        bytes.add(temp[i]);
      }
     isInitialized = true;
    }
    return bytes;
  }

  function collect(byte){
    brainFuckBuffer.add(chr(byte));
  }

  function getBrainfuckBuffer(){
    return brainFuckBuffer;
  }

  function print(){
   var i = 1;
   for(i; i <= brainFuckBuffer.size();i++){
     writeoutput(brainFuckBuffer[i]);
   }
  }

  function stringValue(){
   var i = 1;
   var s = '';
   for(i; i <= brainFuckBuffer.size();i++){
     s &= brainFuckBuffer[i];
   }
   return s;
  }


 function setDebug(flag){
    debugFlag = flag;
  }

  function getDebug(){
    return debugFlag;
  }

  function setInitialized(flag){
    isInitialized =  flag;
  }


</cfscript>


<cffunction name="__throw">
 <cfargument name="message" />
 <cfargument name="detail" required="false" default="" />
 <cfthrow type="BrainfuckParserException" message="#arguments.message#" detail="#arguments.detail#" />
</cffunction>


<cffunction name="printDebug">
 <cfscript>
  	if(!debugFlag) writeoutput('<p><strong>Warning</strong>: Looks like setBug() is false. Set it to true to capture debug data.</p>');
    brainBugger.printDebug();
  </cfscript>
</cffunction>



</cfcomponent>


