<cfcomponent output="true">
<cfsetting showdebugoutput="false">
  <cfscript>

     raw = '';
     program = [];
     brainFuckBuffer = []; //results cache
     pc = 1;
     debugFlag = false;
     isInitialized =  false;
     outputFormat = 'text';
     parser = createObject('component','BrainfuckParser');
     brainBugger = createObject('component','BrainfuckDebugger');

  function init(debug){
    setDebug(debug);
    return this;
  }


  function execute(bytes){
		var byte =  chr(0);
		var pos = {};
		var tempBytes = [];
		var i = 1;

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

     if( pc > 100 || pc < 0) __throw('Range error','loops can kill');

    }//end for
   
  }//end execute

  function interpret(code){
    execute(code);
    print();
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

<cffunction name="exec" access="remote" output="true" returntype="array" returnformat="json">
	<cfargument name="urlEncodedBrainfuck" />
	<cfargument name="debug" required="false" default="false" />
	<cfscript>
	 var fuck = urldecode(arguments.urlEncodedBrainfuck);
	 execute(fuck);
	 return brainFuckBuffer;
	 //if(getDebug()) printDebug();
	</cfscript>
</cffunction>



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


