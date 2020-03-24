<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
	<%
		if(session.getAttribute("currentUser")==null){
			response.sendRedirect("../login/login.jsp");
			return;
		}
	%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>个人信息</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/others/easyui/jquery-easyui-1.3.3/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/others/easyui/jquery-easyui-1.3.3/themes/icon.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/others/easyui/jquery-easyui-1.3.3/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/others/easyui/jquery-easyui-1.3.3/jquery.easyui.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/others/easyui/jquery-easyui-1.3.3/locale/easyui-lang-zh_CN.js"></script>

	<style type="text/css">
		th{
			text-align: right;
			background-color: #EFEFEF;
		}
		.table tr{
			height:40px;
		}
	</style>

	<script type="text/javascript">
		
		var url;
	
		function updateInfo(){
			$("#dlg").dialog("open").dialog("setTitle","修改个人信息");
			url = "${pageContext.request.contextPath }/user/update_personal.html?userId=${currentUser.userId}";
			var gender = "${currentUser.gender}";
			if(gender == "男"){
				$("input:radio[id='gender1']").prop("checked",true); 
			}else if(gender == "女"){
				$("input:radio[id='gender0']").prop("checked",true); 
			}
			
		}
		
		function saveUser_personal(){
			$("#fm").form("submit",{
				url:url,
				onSubmit:function(){
					return $(this).form("validate");
				},
				success:function(result){
					var result=eval('('+result+')');
					if(result.success){
						$("#dlg").dialog("close");
	 					$.messager.show({
							title:'系统提示',
							msg:"<font size='3' color='green'>修改个人信息成功</font>",
							timeout:2000,
							showType:'slide',
							width:300,
							height:150,
							style:{
								top:'',
								left:'',
								right:0,
								bottom:document.body.scrollTop+document.documentElement.scrollTop
							}
						});
	 					window.setTimeout(function(){
	 						window.location.reload();
	 					}, 2000)
					}else{
	 					$.messager.show({
							title:'系统提示',
							msg:"<font size='3' color='green'>修改个人信息失败</font>",
							timeout:2000,
							showType:'slide',
							width:300,
							height:150,
							style:{
								top:'',
								left:'',
								right:0,
								bottom:document.body.scrollTop+document.documentElement.scrollTop
							}
						});
						return;
					}
				}
			});
		}
		
		function closeUserDialog(){
			$("#dlg").dialog("close");
		}
	</script>
</head>
<body style="margin:1px;">
<center>
<div style="padding-left: 30px;padding-top: 20px;" style="overflow-y: hidden;overflow-x: hidden">
	<div id="p" class="easyui-panel" title="个人详细信息" style="width:900px;height: 400px;">
		<div class="table" style="padding-left:23px;padding-top:40px;">
		  <table width="840" border="1" bordercolor="#CBCBCB" cellpadding="5" cellspacing="1">
	        <col width="110" />
	        <col width="140" />
	        <col width="110" />
	        <col width="140" />
	        <tr>
	          <th>真实姓名：</th>
	          <td >&nbsp;&nbsp;${currentUser.trueName}</td>
	          <th>身份证号：</th>
	          <td>&nbsp;&nbsp;${currentUser.idCardNo}</td>
	        </tr>
	        <tr>
	          <th>性别：</th>
	          <td>&nbsp;&nbsp;${currentUser.gender}</td>
	          <th>联系电话：</th>
	          <td>&nbsp;&nbsp;${currentUser.phone}</td>
	          </tr>
	        <tr>
	          <th>用&nbsp;户&nbsp;名：</th>
	          <td>&nbsp;&nbsp;${currentUser.username}</td>
	          <th>密码：</th>
	          <td>&nbsp;&nbsp;******</td>
	        </tr>    
	        <tr>
	          <th>工号：</th>
	          <td>&nbsp;&nbsp;${currentUser.jobNumber}</td>
	          <th>当前身份：</th>
	          <td>&nbsp;&nbsp;${currentUser.postName}</td>
	          </tr>
	       <tr>
	       	 <th>联系地址：</th>
	         <td colspan="3">&nbsp;&nbsp;${currentUser.address}</td>
	       </tr> 
	   </table>
	   </div>
	   <center>
		  <div style="padding-top: 20px;">
			  <a id="btn" href="javascript:updateInfo()" class="easyui-linkbutton" data-options="iconCls:'icon-save'">修改信息</a>  
		  </div>
	   </center>
	</div>
</div>
</center>
 	<div id="dlg" class="easyui-dialog" style="width: 600px;height:260px;padding: 10px 20px"
	  closed="true" buttons="#dlg-buttons">
	 	<form id="fm" method="post" style="text-align:right;">
	 		<table cellspacing="8px">
	 			<tr>
	 				<td>真实姓名：</td>
	 				<td><input type="text" id="trueName" name="trueName" class="easyui-validatebox" style="width:150px;" required="true" value="${currentUser.trueName }"/></td>
	 				<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
	 				<td>用&nbsp;户&nbsp;名：</td>
	 				<td><input type="text" id="username" name="username" class="easyui-validatebox" style="width:150px;" required="true" value="${currentUser.username }"/></td>
	 			</tr>
	 			<tr>
	 				<td>身&nbsp;份&nbsp;证：</td>
	 				<td><input type="text" id="idCardNo" name="idCardNo" class="easyui-validatebox" style="width:150px;" required="true" value="${currentUser.idCardNo }"/></td>
	 				<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
	 				<td>身&nbsp;&nbsp;&nbsp;&nbsp;份：</td>
	 				<td><input type="text" id="postName" name="postName" class="easyui-validatebox" style="width:150px;" required="true" value="${currentUser.postName }" readonly="readonly"/></td>
	 			</tr>
	 			<tr>
	 				<td>密&nbsp;&nbsp;&nbsp;&nbsp;码：</td>
	 				<td><input type="text" id="password" name="password" class="easyui-validatebox" style="width:150px;" required="true" value="${currentUser.password }"/></td>
	 				<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
	 				<td>性&nbsp;&nbsp;&nbsp;&nbsp;别：</td>
	 				<td style="text-align:left;">
	 					<input id="gender1" class="easyui-radio" type="radio" name="gender" value="男"  panelHeight="auto"> 男
	 					&nbsp;&nbsp;
        				<input id="gender0" class="easyui-radio" type="radio" name="gender" value="女"  panelHeight="auto"> 女
	 				</td>
	 			</tr>
	 			<tr>
	 				<td>工&nbsp;&nbsp;&nbsp;&nbsp;号：</td>
	 				<td><input type="text" id="jobNumber" name="jobNumber" class="easyui-validatebox" style="width:150px;" required="true" value="${currentUser.jobNumber}"/></td>
	 				<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
	 				<td>联系电话：</td>
	 				<td><input type="text" id="phone" name="phone" class="easyui-validatebox" style="width:150px;" required="true" value="${currentUser.phone}"/></td>
	 			</tr>
	 			<tr>
	 				<td>联系地址：</td>
	 				<td colspan="4" style="text-align:left;">
	 					<input type="text" id="address" name="address" class="easyui-validatebox" required="true" style="width: 99%;" value="${currentUser.address}"/>
	 					<input type="hidden" id="postId" name="postId" required="true" value="${currentUser.postId}"/>
	 				</td>
	 			</tr>
	 				
	 		</table>
	 	</form>
	</div>
	
	<div id="dlg-buttons">
		<a href="javascript:saveUser_personal()" class="easyui-linkbutton" iconCls="icon-ok">保存</a>
		<a href="javascript:closeUserDialog()" class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
	</div> 
</body>
</html>