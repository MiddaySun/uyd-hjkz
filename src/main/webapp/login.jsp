<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<base href="<%=basePath%>">
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>登录</title>
</head>
<body>
	<form action="/uyd-hjkz/user/login.html" method="post">
		<label>账号：</label>
		<input type="text" id="txtUsername" name="username" placeholder="请输入账号" /><br/>
		<label>密码：</label>
		<input type="password" id="txtPassword" name="password" placeholder="请输入密码" /><br/>
		<input type="submit" value="提交" />
		<input type="reset" value="重置" />
	</form>
</body>
</html>