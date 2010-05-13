<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="mockey" uri="/WEB-INF/mockey.tld" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html lang="en">
<head>
<title>Mockey - <c:out value="${requestScope.pageTitle}"/></title>
<meta http-equiv="content-type" content="text/html; charset=iso-8859-1">
<link rel="shortcut icon" href="<c:url value="/images/favicon.ico" />">
<link rel="stylesheet" type="text/css" href="<c:url value="/style.css" />" />
<link rel="stylesheet" type="text/css" href="<c:url value="/jquery-ui-1.8.custom/css/smoothness/jquery-ui-1.8.custom.css" />" />
<script type="text/javascript" src="<c:url value="/javascript/util.js" />"></script>
<script type="text/javascript" src="<c:url value="/jquery-ui-1.8.custom/js/jquery-1.4.2.min.js" />"></script>
<script type="text/javascript" src="<c:url value="/jquery-ui-1.8.custom/js/jquery-ui-1.8.custom.min.js" />"></script>
<script type="text/javascript" src="<c:url value="/javascript/jquery-jeditable-min.js" />"></script>
<script type="text/javascript" src="<c:url value="/javascript/jquery-impromptu.2.7.min.js" />"></script>
<script type="text/javascript" src="<c:url value="/javascript/jquery.textarearesizer.compressed.js" />"></script>

<script LANGUAGE="Javascript">
<!---
function decision(message, url){
if(confirm(message)) location.href = url;
}
// --->


$(document).ready(function() {
	$('textarea.resizable:not(.processed)').TextAreaResizer();

	// 
	$.getJSON('<c:url value="/proxystatus" />', function(data) {
		if(data.result.proxy_enabled=='true'){
       	   $("#proxy_on").show();
       	   $("#proxy_off").hide();
	     }else {
	    	 $("#proxy_on").hide();
	    	 $("#proxy_off").show(); 
	     }
	});
	
    $('#flush').click(
        function () {
             $.prompt(
                    'Are you sure? This will delete everything. You may want to <a href="<c:url value="/export" />">export your stuff</a> first.', {
                        callback: function (proceed) {
                            if(proceed) document.location="<c:url value="/home?action=deleteAllServices" />";
                        },
                        buttons: {
                            'Delete Everything': true,
                            Cancel: false
                        }
                    }
                );
        })
});


</script>
</head>
<body>
<div id="container">

<div id="logo">
    <img src="<c:url value="/images/logo.png" />" />
    
<%@ include file="/WEB-INF/common/message.jsp"%>
<%
String ua = request.getHeader( "User-Agent" );
boolean isFirefox = ( ua != null && ua.indexOf( "Firefox/" ) != -1 );
boolean isMSIE = ( ua != null && ua.indexOf( "MSIE 6.0" ) != -1 );
response.setHeader( "Vary", "User-Agent" );
%>
<% if( isMSIE ){ %>
  <span class="alert_message" style="position:absolute; top:0; right:200; width:500px;">This isn't designed for <b>Internet Explorer 6.0</b>. You should use another browser.</span>
<% } %>

<ul id="minitabs">
    <li><a title="Service Setup - create new service" href="<c:url value="/setup" />" style="color:red;font-size:1em;">+</a></li>
    <li><a <c:if test="${currentTab == 'merge'}">id ="current"</c:if> title="Merge - combine services" href="<c:url value="/merge" />" style=""><img vertical-align="middle" src="<c:url value="/images/merge.png" />"/></a></li>
    <li><a <c:if test="${currentTab == 'home'}">id ="current"</c:if> href="<c:url value="/home" />">Services</a></li>
    <li><a <c:if test="${currentTab == 'upload'}">id ="current"</c:if> href="<c:url value="/upload" />">Import</a></li>
    <li><a <c:if test="${currentTab == 'export'}">id ="current"</c:if> href="<c:url value="/export" />">Export</a></li>
    <li><a <c:if test="${currentTab == 'history'}">id ="current"</c:if> href="<c:url value="/history" />">History</a></li>
    <li><a <c:if test="${currentTab == 'proxy'}">id ="current"</c:if> href="<c:url value="/proxy/settings" />">Proxy (<span class="tiny" id="proxy_on" style="display:none;">ON</span><span id="proxy_off" class="tiny" style="display:none;">OFF</span>)</a></li>     
    <li><a id="flush" href="#">Flush</a></li>
    <li><a <c:if test="${currentTab == 'help'}">id ="current"</c:if> href="<c:url value="/help" />">Help</a></li></ul>
</div>
