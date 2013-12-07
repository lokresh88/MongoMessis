<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="java.util.List"%>
<%
    response.setHeader("Cache-Control", "no-cache");
			response.setDateHeader("Expires", 0);
%>

<html>
<head>

<script language="JavaScript" type="text/javascript"
	src="../jquery_min.js"></script>
<link rel="stylesheet"
	href="http://code.jquery.com/ui/1.10.2/themes/smoothness/jquery-ui.css" />
<script language="JavaScript" type="text/javascript"
	src="../jquery_ui.js"></script>
<link rel="stylesheet"
	href="http://code.jquery.com/ui/1.9.1/themes/base/jquery-ui.css" />
<link type="text/css" rel="stylesheet" href="../mongoeval.css" />
<script language="JavaScript" type="text/javascript"
	src="../mongoeval.js"></script>
<script language="JavaScript" type="text/javascript"
	src="../jqueryselectbox.js"></script>
<script src="http://jhere.net/js/jhere.js"></script>
<script src="../js/jqChartJQueryPlugin_3_6_2_0/js/jquery.jqChart.min.js" type="text/javascript"></script>
    <script src="../js/jqChartJQueryPlugin_3_6_2_0/js/jquery.jqRangeSlider.min.js" type="text/javascript"></script>
    

<script>
	$(function() {
		$("#radio").buttonset();
	});
</script>

</head>

<body>
	<div id="mainContent">
		<div class="heading">			
			<span style="left: 35%; position: absolute; top: 31%"><img alt="" src="http://www.joyent.com/content/07-blog/722-joyent-to-sponsor-and-present-at-mongosv-2012/mongodb-leaf.png" height="40" width="30"><span style="color: #AB093F;">Mongo Eval</span>
				<span id="keyword"> </span>
			</span>
			<span style="float: right; font-family: cursive; position: relative; font-size: 15px; top: 67%; left: -1%;color: #BEB49C;font-style: italic;"><span id="info"> </span>
			</span>
		</div>
		<div class="line"></div>
		<div class="">
		<span style="display:none;top:1%;top:21%;position: fixed;font-family: cursive;"> No of tweets : <span id="cTC" style="color: #BEB49C"></span></span>
			<div id="radio" class="menu-css"> Test   :   
				<input type="radio" id="radio1" name="radio"
				 /><label for="radio1">
					Read-Write-update</label> <input type="radio"
					id="radio2" name="radio" /><label for="radio2">Connections</label> <input
					type="radio" id="radio3"
					name="radio" /><label for="radio3">Indexing</label>
			</div>
			<span style="display:none;left:59%;top:21%;position: fixed;font-family: cursive;"> No of re-tweets : <span id="rTC" style="color: #BEB49C"></span></span>
			<div class="suggestionBox" id="suggestionsDiv">
				<p class="headerkeys">Parameters</p>
				<div id='keywordsList'>
				<p style="font-size: 14">DbName: <select><option value="userTable">userTable</option></select></p>
				<p style="font-size: 14">Operations: 
				<select id="ops">
				<option value="1000">1000</option>
				<option value="2000">2000</option>
				<option value="3000">3000</option>
				<option value="4000">4000</option>
				<option value="5000">5000</option>
				<option value="6000">6000</option>
				<option value="7000" selected="selected">7000</option>
				</select> / sec
				</p>
				<p style="font-size: 14" >Fields: 
				<select id="flds">
				<option value="10" selected="selected">10</option>
				<option value="20">20</option>
				<option value="30">30</option>
				<option value="40">40</option>
				<option value="50">50</option>
				</select>
				
				</p>
				<p style="font-size: 14" >Connections: 
				<select id="conn">
				<option value="1" selected="selected">1</option>
				<option value="10">10</option>
				<option value="20">20</option>
				<option value="30">30</option>
				<option value="40">40</option>
				<option value="50">50</option>
				</select></p>
				
				<button id="subButton" value="" onclick="javascript:sendOpts()" style="font-size: 14;position: absolute;left: 30%" >Run-Test</button>
				</div>
			</div>
			<div>
				<div class="midBox">
					<div id="displayDiv" style="display: none;width: 45%;margin-top:50px; float:left;display: inline;">
					
					</div>
					<div id="displayDiv2" style="display: none;width: 45%;margin-top:50px;display: inline;float: right;">
					
					</div>
					
					<div id="comparisonDiv" style="display: none;height: 90%;width: 90%;position: relative;"></div>
					<div id="timeLineDiv" style="display: none;height: 90%;width: 90%;position: relative;"></div>
				</div>

			</div>
		</div>
		<div id="results" geo="" comp="" timeline="" style="display: none;">
		</div>
		<div id="loading" style="display: none;">
			<img src="../images/ajax-loader.gif" />
		</div>
</body>
</html>
<script>


$(function() {
$( "#subButton")
.button()
.click(function( event ) {
event.preventDefault();
});
});

	$(document).ready(function() {

		//populateCelebs();

	});

	$(window).on('load', function() {
	/*	$('#displayDiv').jHERE({
			enable : [ 'behavior', 'zoombar' ],
			zoom : 1,
			type : 'terrain'
		});*/

	});

	$(document).ajaxStart(function() {
		$("#loading").show();
	});

	$(document).ajaxStop(function() {
		$("#loading").hide();
	});
</script>

