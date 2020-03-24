<%@ page language="java"  import="java.util.*" contentType="text/html; charset=UTF-8" 
	pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
  <head>
<base href="<%=basePath%>">
    <title>登陆界面</title>    
	<meta name="keywords" content="" />
	<meta name="description" content="" />
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link rel="stylesheet" href="pages/login/css/font-awesome.min.css"/>
	<link rel="stylesheet" href="pages/login/css/loginMy.css"/>


	<script type="text/javascript">
	windows.onload=(function(){
		document.getElementById('tip').innerHTML = "";
	});
	 	function removeTip(){
			document.getElementById('tip').innerHTML = "";
		}
	</script>
  </head>
  
  <body>
<div class="main">
				<div style="padding-top:5px;margin-top:-48px; text-align:center">
					<font size="6"  style="font-family: cursive;color: #fFF">Welcome to Environmental Monitoring System</font>
				</div>
<div class="center">
		<form action="${pageContext.request.contextPath }/user/login.html" id="formOne" method="post" onsubmit="return submitB()" >
			<i class="fa fa-user Cone">  &nbsp;| </i>
		  <input type="text" id="username" name="username" value=""  placeholder="用户名" onfocus="removeTip() " onblur="checkUser()"/>
			<span id="user_pass"></span>
			<br/>
			<i class="fa fa-key Cone">  | </i>
			<input type="password" id="password" name="password" value="" placeholder="密码"  onfocus="removeTip() " onblur="checkUser1()"/>
			<span id="pwd_pass"></span>
			<br/>
				
			<br/>
			<span style="padding-left:38%; " id="tip"><font style="text-align:center;" color="#fff">${errorMsg}</font></span>
			<br/>
			<input align="center" type="submit" value="登录        " id="submit" name="提交">
			<br/>
			
    </form>
	
  </div>
</div>

<script type="text/javascript" src="pages/login/js/loginMy.js" ></script>




  </body>

