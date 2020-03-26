<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
	
	<!-- 防止用户直接输入主界面的url进入 -->
	<%
		if(session.getAttribute("currentUser")==null){
			response.sendRedirect("../login/login.jsp");
			return;
		}
	%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>${currentSysInfo.sysName}</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/others/easyui/jquery-easyui-1.3.3/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/others/easyui/jquery-easyui-1.3.3/themes/icon.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/others/easyui/jquery-easyui-1.3.3/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/others/easyui/jquery-easyui-1.3.3/jquery.easyui.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/others/easyui/jquery-easyui-1.3.3/locale/easyui-lang-zh_CN.js"></script>

<style type="text/css">
	a button{
		outline:none;
	}
</style>

<script type="text/javascript">
	window.onload = function(){
			var oDiv = document.getElementById('time');

			function timego(){			
				var now = new Date();
				var year = now.getFullYear();
				var month = now.getMonth()+1;
				var date = now.getDate();
				var week = now.getDay();
				var hour = now.getHours();
				var minute = now.getMinutes();
				var second = now.getSeconds();
				oDiv.innerHTML = year+'年'+todou(month)+'月'+todou(date)+'日'+' '+toweek(week)+'  '+ todou(hour) +':'+ todou(minute)+':'+todou(second);
			}

			timego();


			setInterval(timego,1000);

		}


		function toweek(num){

			switch(num){
				case 0:
					return '星期天';
					break;
				case 1:
					return '星期一';
					break;
				case 2:
					return '星期二';
					break;
				case 3:
					return '星期三';
					break;
				case 4:
					return '星期四';
					break;
				case 5:
					return '星期五';
					break;
				case 6:
					return '星期六';
					break;
			}
		}

		function todou(num){

			if(num<10){
				return '0'+num;				
			}
			else
			{
				return num;
			}

		}


	var url;
	
	function openTab(text,url,iconCls){
		if($("#center_tabs").tabs("exists",text)){
			$("#center_tabs").tabs("select",text);
		}else{
			var content="<iframe frameborder=0 scrolling='auto' style='width:100%;height:100%' src='${pageContext.request.contextPath}/pages/main/"+url+"'></iframe>";
			$("#center_tabs").tabs("add",{
				title:text,
				iconCls:iconCls,
				closable:true,
				content:content
			});
		}
	}
	
	function openPasswordModifyDialog(){
		$("#dlg").dialog("open").dialog("setTitle","修改密码");
		url="${pageContext.request.contextPath }/user/modifypwd.html?userId=${currentUser.userId}"; 
	}
	
	<!--关闭修改密码的模态框-->	
	function closePasswordModifyDialog(){
		$("#dlg").dialog("close");
		$("#oldPassword").val("");
		$("#newPassword").val("");
		$("#newPassword2").val("");
	}
	
	function modifyPassword(){
		$("#fm").form("submit",{
			url:url,
			onSubmit:function(){
				var oldPassword=$("#oldPassword").val();
				var newPassword=$("#newPassword").val();
				var newPassword2=$("#newPassword2").val();
				if(!$(this).form("validate")){
					return false;
				}
				if(oldPassword!='${currentUser.password}'){
					$.messager.alert("系统提示","<font size='3' color='green'>用户原密码输入错误 !<font>");
					return false;
				}
				if(newPassword!=newPassword2){
					$.messager.alert("系统提示","<font size='3' color='green'>两次密码输入不一致!<font>");
					return false;
				}
				return true;
			},
			success:function(result){
				var result = eval('('+result+')');
				if(result.success){
					closePasswordModifyDialog();
 					$.messager.show({
						title:'系统提示',
						msg:"<font size='3' color='green'>密码修改成功，下次登录生效！</font>",
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
				}else{
					$.messager.show({
						title:'系统提示',
						msg:"<font size='3' color='green'>密码修改失败！</font>",
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
	
	function logout(){
		$.messager.confirm("系统提示","您确定要退出系统吗",function(r){
			if(r){
				window.location.href="${pageContext.request.contextPath }/user/exit.html"; 
			}
		});
	}
	
	
</script>
</head>
<body class="easyui-layout">   
    <div data-options="region:'north',split:true" style="overflow-y: hidden;background:url('${pageContext.request.contextPath}/others/images/top.png')no-repeat center;background-size:100% 100%;width:100%;height:115px">
		<div style="width:100%;height:115px;text-align:right;position:relative;position:absolute;">
			<div style="width:300;height:115px;display: inline-block;text-align:center;">
				<div style="width:100%;height:60px;margin-top:50px;">
					<h3 style="color:#FFFFFF;font-weight:normal"><label>当前用户：${currentUser.username}&nbsp;&nbsp;&nbsp;&nbsp;</label><label id="time" style="">------------</label></h3>
				</div>
			</div>
			<div s style="width:150;height:115px;text-align:right;display: inline-block;">
<%-- 				<input type="button" onclick="javascript:logout()" style="cursor:pointer;border:0;height:50px;width:127px;background:url('${pageContext.request.contextPath}/others/images/home.png');vertical-align:middle;margin-top:-8px;margin-right:20px;"> --%>
				<input type="button" onclick="javascript:logout()" style="cursor:pointer;border:0;height:50px;width:127px;background:url('${pageContext.request.contextPath}/others/images/exit.png');vertical-align:middle;margin-top:-8px;margin-right:20px;">
			</div>
			</div>
		
<%-- 		<img src="${pageContext.request.contextPath}/others/images/top.png" style="width:100%;height:100%">          border:0;                        --%>
<!-- 			<div style="padding-left:15px;padding-top:5px;"> -->
<%-- 				<img src="${pageContext.request.contextPath}/others/images/top.png">&nbsp;&nbsp;  --%>
<!-- 				<div style="padding-top:5px;; padding-left:55px;margin-top:-48px; "> -->
<%-- 					<font size="6" style="font-family: cursive;">${currentSysInfo.sysName}</font> --%>
<%-- 					<font size="1" style="font-family: cursive;">${currentSysInfo.sysVersionNo}</font> --%>
<!-- 				</div> -->
<!-- 			</div> -->
<!-- 			<div style="margin-top: -48px;text-align:right;"> -->
<%-- 				<font size="6" style="font-family: cursive;">当前用户：<font color="red">${currentUser.username}</font></font> --%>
<!-- 			</div> -->
    </div>   
    
    <div data-options="region:'south',title:'<center></center>',split:true" style="height:35px;background:#005F89";></div> 
      
	 <div region="west" style="width: 230px; background:#4BA4D0;" title="导航菜单" split="true">
		<div class="easyui-accordion" data-options="fit:true,border:false" style="background:#4BA4D0;">
			<div title="用户管理" data-options="iconCls:'icon-user'" style="padding: 10px;background:#4BA4D0;">
				<c:if test="${currentUser.postId=='admin' }">
					<a href="javascript:openTab('用户列表','userList.jsp','icon-c-user-list')" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-c-user-list'" style="width: 150px;">用户列表</a>
				</c:if>
				<a href="javascript:openTab('个人信息','userInfo.jsp','icon-c-user')" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-c-user'" style="width: 150px;">个人信息</a>
			</div>
			<div title="设备信息" data-options="iconCls:'icon-item'" style="padding: 10px;background:#4BA4D0;">
				<a href="javascript:openTab('温湿度曲线','wsdCharts.jsp','icon-item')" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-item'" style="width: 150px;">温湿度曲线</a>
				<a href="javascript:openTab('设备列表','deviceList.jsp','icon-item')" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-item'" style="width: 150px;">设备列表</a>
			</div>
<!-- 			<div title="类别管理" data-options="iconCls:'icon-tag'" style="padding: 10px"> -->
<!-- 				<a href="javascript:openTab('类别列表','typeList.jsp','icon-tag-edit')" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-tag-edit'" style="width: 150px;">类别列表</a>  -->
<!-- 			</div> -->
<!-- 			<div title="销售管理" data-options="iconCls:'icon-doc-list'" style="padding: 10px"> -->
<!-- 				<a href="javascript:openTab('选购药品','buyMedicine.jsp','icon-doc-type')" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-doc-type'" style="width: 150px;">选购药品</a>  -->
<!-- 				<a href="javascript:openTab('订单管理','sellList.jsp','icon-doc-type')" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-doc-type'" style="width: 150px;">订单管理</a>  -->
<!-- 				<a href="javascript:openTab('订单记录','YSellList.jsp','icon-doc-type')" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-doc-type'" style="width: 150px;">订单记录</a>  -->
<!-- 			</div> -->
<!-- 			<div title="进货管理" data-options="iconCls:'icon-product'" style="padding: 10px"> -->
<!-- 				<a href="javascript:openTab('库存信息','numList.jsp','icon-wrench')" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-wrench'" style="width: 150px;">库存信息</a>  -->
<%-- 				<c:if test="${currentUser.postId=='admin' }"> --%>
<!-- 					<a href="javascript:openTab('订单信息','inOrderList.jsp','icon-wrench')" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-wrench'" style="width: 150px;">订单信息</a>  -->
<%-- 				</c:if> --%>
<!-- 				<a href="javascript:openTab('进货记录','YInOrderList.jsp','icon-wrench')" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-wrench'" style="width: 150px;">进货记录</a>  -->
<!-- 			</div> -->
	 		<div title="系统功能"  data-options="iconCls:'icon-item'" style="padding:10px;background:#4BA4D0;">
				<a href="javascript:openPasswordModifyDialog()" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-modifyPassword'" style="width: 150px;">修改密码</a>
			</div>
			
			<div title="当前日期"  data-options="selected:true,iconCls:'icon-safe-log'" style="padding:10px;background:#4BA4D0;">
				<div class="easyui-calendar" style="width:200px;height:200px;"></div>
			</div>
		</div>
	</div>
    
    <div data-options="region:'center',title:' &nbsp;功能主界面'" style="padding:2px;">
    	<div id="center_tabs" class="easyui-tabs" fit="true" style="background:#4BA4D0;">
    		<div title="首页" data-options="iconCls:'icon-home'" align="center" >
    		</div>
    	</div>
    </div>  
    
    <div id="dlg" class="easyui-dialog" style="width: 400px;height:230px;padding: 10px 20px"
  		closed="true" closeable="false" buttons="#dlg-buttons">
	 	<form id="fm" method="post">
	 		<table cellspacing="8px">
	 			<tr>
	 				<td>用户名：</td>
	 				<td><input type="text" id="username" name="username" value="${currentUser.username }" readonly="readonly" style="width: 200px"/></td>
	 			</tr>
	 			<tr>
	 				<td>原密码：</td>
	 				<td><input type="password" id="oldPassword" class="easyui-validatebox" required="true" style="width: 200px"/></td>
	 			</tr>
	 			<tr>
	 				<td>新密码：</td>
	 				<td><input type="password" id="newPassword" name="newPassword" class="easyui-validatebox" required="true" style="width: 200px"/></td>
	 			</tr>
	 			<tr>
	 				<td>确认新密码：</td>
	 				<td><input type="password" id="newPassword2"  class="easyui-validatebox" required="true" style="width: 200px"/></td>
	 			</tr>
	 		</table>
	 	</form>
	</div>

	<div id="dlg-buttons">
		<a href="javascript:modifyPassword()" class="easyui-linkbutton" iconCls="icon-ok" style="outline: none">保存</a>
		<a href="javascript:closePasswordModifyDialog()" class="easyui-linkbutton" iconCls="icon-cancel" style="outline: none">关闭</a>
	</div> 
</body> 
</html>