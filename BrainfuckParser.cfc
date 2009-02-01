<cfcomponent output='true'>
<cfscript>


  function parse(bytes){
    var i = 1;
    var cnt = 0;
    var msg = '';
    for(;arrayLen(bytes) >= i; i++){
      if(bytes[i] == 91) cnt++;
      else if(bytes[i] == 93) cnt--;
    }
     if(cnt) {
        msg &= 'cnt returned : #cnt# ; Possibly #abs(cnt)# bracket(s) unbalanced ';
         __throw('Unbalance Brackets',msg);
     }
     return true;
   }


  function match(bytes){
    var i = 1;
    var cnt = 0;
    var position = structNew();
    position.start = 0;
    position.end = 0;
    for(;arrayLen(bytes) >= i; i++){
      if(bytes[i] == 91){
         cnt++;
         if(!position.start){
         	 position.start = i;
         }
      }
      else if(bytes[i] == 93) {
        cnt--;
        if(!cnt) {
          position.end = i;
          return position;
       }
      }
    }
    return position;
  }



  function convertBrainfuckToBytes(brainfuck){
    return brainfuck.getBytes();
  }


  function convertBytesToBrainfuck(bytes){
    var retBytes =  [];
    var i = 1;
    for(; i <= arrayLen(bytes); i++){
      retBytes[i] = bytes[i];
    }
   return createObject('java','java.lang.String').
                   init( javacast('byte[]',retBytes) );
  }


  function extract(bytes,start,end){
    var retBytes = [];
    var i = 1;
    for(; start < end-1; i++){
      start++;
      retBytes.add(bytes[start]);
    }
    return retBytes;
  }

  function refactorArrayReference(bytes,start){
    var temp =  duplicate(bytes.sublist(start,bytes.size() ));
    bytes.clear();
    for(i=1;i<=temp.size();i++){
      bytes.add(temp[i]);
    }
  }






</cfscript>

<cffunction name="__throw">
 <cfargument name="message" />
 <cfargument name="detail" required="false" default="" />
 <cfthrow type="BrainfuckParserException" message="#arguments.message#" detail="#arguments.detail#" />
</cffunction>
</cfcomponent>