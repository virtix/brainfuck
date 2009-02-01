<cfcomponent>
<cfscript>
  debugString = '';
  raw = '';

  function init(raw){
  	raw = arguments.raw;
    return this;

  }

   function printDebug(){
     printDebugHeader();
     printDebugString();
     printDebugFooter();
  }


  function debug(byte,pc,program){
    debugString &= '
    <tr>
     <td>#byte#</td>
     <td>#chr(byte)#</td>
     <td>#pc#</td>
     <td>#program[pc]#</td>';

     if(byte == 46){
	     debugString &= '
	     <td bgcolor="orange">#chr(program[pc])#&nbsp;</td>
	     </tr>';
     }
     else {
      debugString &= '
	     <td>&nbsp;</td>
	     </tr>';
     }
   }



  function printDebugHeader(){
   var debugHeader = '
		  <h3>Debug Output for CF Brainfuck parser</h3>
		  Code:<pre>#raw#</pre>
		  <table border="1" style="font-family:courier new;font-size:11px;border:1px ridge silver">
		   <tr bgcolor="eaeaea">
		   <td width="40">byte</td>
		   <td width="40">char</td>
		   <td width="40">pc</td>
		   <td width="60">program[pc]</td>
		   <td width="60">output</td>
		  </tr>
		 ';
		writeoutput(debugHeader);
  }


  function printDebugString(){
    writeoutput(debugString);
  }

  function printDebugFooter(){
	writeoutput('</table>');
  }

  function getDebugString(){
   return debugString;
  }

  function getRaw(){
   return raw;
  }

</cfscript>

<cffunction name="__dump">
	<cfargument name="o"/>
 <cfargument name="label" required="false" default="Brainfuck Dump" />
 <cfargument name="expand" required="false" default="true" />
 <cfdump var="#arguments.o#" label="#arguments.label#" expand="#arguments.expand#" />
</cffunction>


</cfcomponent>