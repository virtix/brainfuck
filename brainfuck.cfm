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
  }

  function fuckme(){
    var bfObjt = document.getElementById('src');
    var bf = bfObjt.value;
    console.log(bf);
    //p = escape('+++++++++++++[>+++++<-]>.');
    //p = '++++++++++[>+++++++>++++++++++>+++>+<<<<-]>++.>+.+++++++..+++.>++.<<+++++++++++++++.>.+++.------.--------.>+.>.';
    bf = escape(bf);
    bf = bf.replace(/\+/g,'%2B');
    console.log('bf afterparse : ' + bf);
    u = 'Brainfuck.cfc?method=exec&urlEncodedBrainfuck=' + bf;
    console.log(u);
  $.getJSON(u,
        function(data){
         $.each(data, function(i,item){
             $('#brainfucked')
            .append(item);
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
        <li><a href="#linx"><span>Brainfuck Resources</span></a></li>
        <li><a href="#license"><span>License</span></a></li>
    </ul>

    <div id="interpret">
        <p>
        <textarea id="src" style="width:100%" rows="8" onclick="removeDefault(this)">++++++++++[>+++++++>++++++++++>+++>+<<<<-]>++.>+.+++++++..+++.>++.<<+++++++++++++++.>.+++.------.--------.>+.>.</textarea><br />
         Or, load from file: <input id="bffile" size="40" type="file">
         <input type="button" value="Load BF" />
         <input type="button" value="Run" onclick="fuckme()" />
				 <input type="button" value="Reset" onclick="location.href='brainfuck.cfm'" />
				 &nbsp;&nbsp;&nbsp;
				 Show Debug:

				 <input type="radio" name="debug" value="true"> Yes

				 <input type="radio" name="debug" value="false" checked="true"> No

        <p><hr size="1" noshade="true" color="#eaeaea" width="95%" /></p>
        <h4>Brainfucked Console: <input type="button" value="Clear Console" onclick="clearOutput()" /></h4>
				<pre id="brainfucked" style="width:100%;border:1px ridge gray;background-color:whitesmoke;height:20%;overflow:scroll" rows="8"  style="font-size:11px;font-face:courier"></pre>
        </p>

    </div>
    <div id="linx">
    <ul>
     <li>http://daniel.lorch.cc/projects/brainfuck/php-brainfuck-1.01/doc.html</li>
     <li>http://www.iwriteiam.nl/Ha_BF.html</li>
     <li>Link #3</li>
    </ul>
    </div>
    <div id="license">
   <pre style="font-size:11px">
   <cfinclude template="Apache-2.0.license">
    </pre>
   </div>
</div><br />
<div align="center">UI compliments of <a href="http://jquery.com">JQuery</a></div>
</body>
</html>