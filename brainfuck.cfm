<cfsetting showdebugoutput="false">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
 <title>Brainfuck Interpretter for ColdFusion</title>
  <link rel="icon" type="image/png" href="favicon.ico"/>
  <link type="text/css" href="resources/ui.all.css" rel="Stylesheet" />
  <script type="text/javascript" src="resources/jquery-1.3.1.min.js"></script>
	<script type="text/javascript" src="resources/jquery.ui.all.js"></script>
	<style type="text/css">
		body{ font: 62.5% Verdana, sans-serif; background-color:darkred }
		/*demo page css*/
		#dialog_link {padding: .4em 1em .4em 20px;text-decoration: none;position: relative;}
		#dialog_link span.ui-icon {margin: 0 5px 0 0;position: absolute;left: .2em;top: 50%;margin-top: -8px;}
		ul#icons {margin: 0; padding: 0;}
		ul#icons li {margin: 2px; position: relative; padding: 4px 0; cursor: pointer; float: left;  list-style: none;}
		ul#icons span.ui-icon {float: left; margin: 0 4px;}
	</style>

 <script>
   $(document).ready(function(){
    $("#brainfuck").tabs();
  });

  function removeDefault(textArea){
   if(textArea.value=='[Enter Brainfuck code here]')textArea.value='';
  }

  function clearOutput(){
   $('#brainfucked').html('');
   $('#debug').html('');
  }

  function fuckme(){
    var bfObjt = document.getElementById('src');
    var bf = bfObjt.value;
    var debug = $("input[@name='debugFlag']:checked").val();
    console.log(debug);
    console.log(bf);
    bf = escape(bf);
    bf = bf.replace(/\+/g,'%2B'); //need to replace +'s with %2B
    console.log('bf afterparse : ' + bf);
    u = 'Brainfuck.cfc?method=exec&debug=' + debug + '&urlEncodedBrainfuck=' + bf;
    console.log(u);
    clearOutput();
	  $.getJSON(u,
	        function(data){
	         $.each(data, function(i,item){
	             if(i == data.length-1) {
	              $('#debug').append(item);
	              return;
	             }
	             $('#brainfucked').append(item);
	          });
	        });
  }
 </script>

</head>
<body>
  <h2 align="center" style="color:silver">Brainfuck Interpreter written in ColdFusion 8
	<div id="sub" align="center" style="font-size:12px;color:gray">&quot;Why? Because it's there.&quot;</div>
	</h2>
  <div id="brainfuck">
   <ul>
        <li><a href="#interpret"><span>Interpreter</span></a></li>
				<li><a href="#debug"><span>Debug</span></a></li>
        <li><a href="#linx"><span>Brainfuck Resources</span></a></li>
        <li><a href="#license"><span>License</span></a></li>
    </ul>

    <div id="interpret" align="center">
        <p>
        <textarea id="src" style="width:100%" rows="8" onclick="removeDefault(this)">++++++++++[>+++++++>++++++++++>+++>+<<<<-]>++.>+.+++++++..+++.>++.<<+++++++++++++++.>.+++.------.--------.>+.>.</textarea><br />
       <!---
			   @To Do
			   Or, load from file: <input id="bffile" size="40" type="file">
         <input type="button" value="Load BF" />
				--->
         <input type="button" value="Run" onclick="fuckme()" />
				 <input type="button" value="Reload Page" onclick="location.href='brainfuck.cfm'" />
				 &nbsp;&nbsp;&nbsp;
				 Show Debug:

				 <input type="radio" name="debugFlag" value="true"> Yes
				 <input type="radio" name="debugFlag" value="false" checked="true"> No


		 <div id="brainfuckconsole" align="left">
			 <h4>Brainfucked Console: <input type="button" value="Clear Console and Debug" onclick="clearOutput()" /></h4>
				<pre id="brainfucked" style="width:100%;border:1px ridge gray;background-color:whitesmoke;height:20%;overflow:auto" rows="8"  style="font-size:11px;font-face:courier"></pre>
    </div>
    </div>


		<div id="debug"></div>

    <div id="linx">
    <ul>
		 <li><a href="http://www.esolangs.org/wiki/Brainfuck">http://www.esolangs.org/wiki/Brainfuck</a></li>
     <li><a href="http://daniel.lorch.cc/projects/brainfuck/php-brainfuck-1.01/doc.html">http://daniel.lorch.cc/projects/brainfuck/php-brainfuck-1.01/doc.html</a></li>
     <li><a href="http://www.iwriteiam.nl/Ha_BF.html">http://www.iwriteiam.nl/Ha_BF.html</a></li>
     <li><a href="http://aminet.net/dev/lang/brainfuck-2.readme">Original README by Urban Müller</a></li>
		<li><a href="http://main.aminet.net/dev/lang/brainfuck-2.lha">Orginal Distribution by Urban Müller</a></li>
    </ul>
    </div>
    <div id="license">
   <pre style="font-size:11px">
   <cfinclude template="Apache-2.0.license">
    </pre>
   </div>
</div>

<br />
<div align="center">UI compliments of <a href="http://jquery.com">JQuery</a></div>
</body>
</html>