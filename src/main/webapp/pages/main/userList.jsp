<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/others/easyui/jquery-easyui-1.3.3/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/others/easyui/jquery-easyui-1.3.3/themes/icon.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/others/easyui/jquery-easyui-1.3.3/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/others/easyui/jquery-easyui-1.3.3/jquery.easyui.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/others/easyui/jquery-easyui-1.3.3/locale/easyui-lang-zh_CN.js"></script>

<script type="text/javascript">
	
	var url;
	
	function searchUser(){
		$("#dg").datagrid('load',{
				"trueName":$("#s_trueName").val()
			});
		}
	
	function deleteUser(){
		var selectedRows=$("#dg").datagrid('getSelections');
		if(selectedRows.length==0){
			$.messager.alert("系统提示","<font size='3' color='green'>请选择要删除的数据！<font>");
			return;
		}
		var strIds=[];
		for(var i=0;i<selectedRows.length;i++){
			strIds.push(selectedRows[i].userId);
		}
		var ids=strIds.join(",");
		$.messager.confirm("系统提示","您确认要删除这<font color=red>"+selectedRows.length+"</font>条数据吗？",function(r){
			if(r){
				$.post("${pageContext.request.contextPath }/user/deleteUser.html",{ids:ids},function(result){
					if(result.success){
						$("#dg").datagrid("reload");
	 					$.messager.show({
							title:'系统提示',
							msg:"<font size='3' color='green'>删除成功！</font>",
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
							msg:"<font size='3' color='green'>删除失败，不能删除当前登录用户！</font>",
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
					}
				},"json");
			}
		});
		
	}
	
	
	function openUserAddDialog(){
		resetValue();
		$("input:radio[id='genderAdd1']").prop("checked",true);
		$("input:radio[id='postIdAdd0']").prop("checked",true);
		$("#dlg").dialog("open").dialog("setTitle","添加用户信息");
		url = "${pageContext.request.contextPath }/user/saveUser.html";
	}
	
	
	function addUser(){
		$("#fm").form("submit",{
			url:url,
			onSubmit:function(){
				return $(this).form("validate");
			},
			success:function(result){
				var result=eval('('+result+')');
				if(result.success){
					resetValue();
					$("#dlg").dialog("close");
					$("#dg").datagrid("reload");
 					$.messager.show({
						title:'系统提示',
						msg:"<font size='3' color='green'>添加用户信息成功</font>",
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
						msg:"<font size='3' color='green'>添加用户信息失败，此用户名已存在！</font>",
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
	
	function updateUser(){
		$("#fm2").form("submit",{
			url:url,
			onSubmit:function(){
				return $(this).form("validate");
			},
			success:function(result){
				var result=eval('('+result+')');
				if(result.success){
					resetValue();
					$("#dlg2").dialog("close");
					$("#dg").datagrid("reload");
 					$.messager.show({
						title:'系统提示',
						msg:"<font size='3' color='green'>修改用户信息成功</font>",
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
						msg:"<font size='3' color='green'>不能修改自己的用户权限，请使用其他账户登录进行修改！</font>",
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
	
	function openUserModifyDialog(){
		resetValue();
		var selectedRows=$("#dg").datagrid('getSelections');
		if(selectedRows.length==0){
			$.messager.alert("系统提示","<font size='3' color='green'>请选择一条要编辑的数据！<font>");
			return;
		}
		if(selectedRows.length>1){
			$.messager.alert("系统提示","<font size='3' color='green'>一次只能编辑一条数据！<font>");
			return;
		}
		var row=selectedRows[0];
		$("#dlg2").dialog("open").dialog("setTitle","编辑用户信息");
		$("#trueName2").val(row.trueName);
		$("#username2").val(row.username);
		$("#password2").val(row.password);
		$("#idCardNo2").val(row.idCardNo);
		$("#phone2").val(row.phone);
		$("#address2").val(row.address);
		$("#jobNumber2").val(row.jobNumber);
		$("#postName2").val(row.postName);
		if(row.gender=='男'){
			$("input:radio[id='gender1']").prop("checked",true); 
		}else if(row.gender=='女'){
			$("input:radio[id='gender0']").prop("checked",true); 
		}
		if(row.postId=='admin'){
			$("input:radio[id='postId1']").prop("checked",true); 
		}else if(row.postId=='common'){
			$("input:radio[id='postId0']").prop("checked",true); 
		}
		url="${pageContext.request.contextPath }/user/update.html?userId="+row.userId;
	}
	
	function resetValue(){
		$("#trueName").val("");
		$("#username").val("");
		$("#password").val("");
		$("#idCardNo").val("");
		$("#phone").val("");
		$("#address").val("");
		$("#jobNumber").val("");
		$("input:radio[id='genderAdd1']").prop("checked",false); 
		$("input:radio[id='genderAdd0']").prop("checked",false);
		$("input:radio[id='postIdAdd1']").prop("checked",false); 
		$("input:radio[id='postIdAdd0']").prop("checked",false);
		$("#trueName2").val("");
		$("#username2").val("");
		$("#password2").val("");
		$("#idCardNo2").val("");
		$("#phone2").val("");
		$("#address2").val("");
		$("#jobNumber2").val("");
		$("input:radio[id='gender1']").prop("checked",false); 
		$("input:radio[id='gender0']").prop("checked",false);
		$("input:radio[id='postId1']").prop("checked",false); 
		$("input:radio[id='postId0']").prop("checked",false);
	}
	
	function closeUserDialog(){
		$("#dlg").dialog("close");
		resetValue();
	}
	
	function closeUpdateUserDialog(){
		$("#dlg2").dialog("close");
		resetValue();
	}
</script>
</head>
<body style="margin:1px;">
	<table id="dg" title="用户列表" class="easyui-datagrid"
	 fitColumns="true" pagination="true" rownumbers="true" 
	 url="${pageContext.request.contextPath }/user/userlist.html" fit="true" toolbar="#tb" striped="true">
	 <thead>
	 	<tr>
	 		<th field="cb" checkbox="true" align="center"></th>
	 		<th field="userId" width="50" align="center">编号</th>
	 		<th field="trueName" width="50" align="center">真实姓名</th>
	 		<th field="username" width="80" align="center">用户名</th>
	 		<th field="gender" width="50" align="center">性别</th>
	 		<th field="jobNumber" width="50" align="center">工号</th>
	 		<th field="idCardNo" width="80" align="center">身份证</th>
	 		<th field="phone" width="100" align="center">联系电话</th>	
	 		<th field="address" width="150" align="center">联系地址</th>
	 		<!-- 修改jquery.easyui.min.js的8670行的代码可以使field使用点连接取二级属性 -->
	 		<th field="postName" width="100" align="center">系统身份</th>
	 	</tr>
	 </thead>
	</table>
	<div id="tb" style="padding-bottom:5px; padding-top:5px; ">
		<div>
			<a href="javascript:openUserAddDialog()" class="easyui-linkbutton" iconCls="icon-add" plain="true">添加</a>&nbsp;&nbsp;
			<a href="javascript:openUserModifyDialog()" class="easyui-linkbutton" iconCls="icon-edit" plain="true">修改</a>&nbsp;&nbsp;
			<a href="javascript:deleteUser()" class="easyui-linkbutton" iconCls="icon-remove" plain="true">删除</a>&nbsp;&nbsp;
			<a href="javascript:searchUser()" class="easyui-linkbutton" iconCls="icon-search" plain="true" style="outline: none">搜索</a>
			<input type="text" id="s_trueName" style="width:200px;" size="20" onkeydown="if(event.keyCode==13) searchUser()" placeholder="请输入您要查找用户的真实姓名"/>
		</div>
	</div>
	
	<div id="dlg" class="easyui-dialog" style="width: 600px;height:260px;padding:10px 20px"
	  closed="true" buttons="#dlg-buttons">
	 	<form id="fm" method="post" style="text-align:right;">
	 		<table cellspacing="8px">
	 			<tr>
	 				<td>真实姓名：</td>
	 				<td><input type="text" id="trueName" name="trueName" style="width:150px;" class="easyui-validatebox" required="true"/></td>
	 				<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
	 				<td>身&nbsp;份&nbsp;证：</td>
	 				<td><input type="text" id="idCardNo" name="idCardNo" style="width:150px;" class="easyui-validatebox" required="true"/></td>
	 			</tr>
	 			<tr>
	 				
	 				<td>用&nbsp;户&nbsp;名：</td>
	 				<td><input type="text" id="username" name="username" style="width:150px;" class="easyui-validatebox" required="true"/></td>
	 				<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
	 				<td>管&nbsp;理&nbsp;员：</td>
	 				<td style="text-align:left;">
	 					<input id="postIdAdd1" class="easyui-checkbox" type="radio" name="postId" value="admin"  panelHeight="auto"> 是
	 					&nbsp;&nbsp;
        				<input id="postIdAdd0" class="easyui-checkbox" type="radio" name="postId" value="common" panelHeight="auto"> 否
	 				</td>
	 			</tr>
	 			<tr>
	 				<td>密&nbsp;&nbsp;&nbsp;&nbsp;码：</td>
	 				<td><input type="password" id="password" name="password" style="width:150px;" class="easyui-validatebox" required="true"/></td>
	 				<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
	 				<td>性&nbsp;&nbsp;&nbsp;&nbsp;别：</td>
	 				<td style="text-align:left;">
	 					<input id="genderAdd1" class="easyui-radio" type="radio" name="gender" value="男" panelHeight="auto"> 男
	 					&nbsp;&nbsp;
        				<input id="genderAdd0" class="easyui-radio" type="radio" name="gender" value="女"  panelHeight="auto"> 女
	 				</td>
	 			</tr>
	 			<tr>
	 				<td>工&nbsp;&nbsp;&nbsp;&nbsp;号：</td>
	 				<td><input type="text" id="jobNumber" name="jobNumber" style="width:150px;" class="easyui-validatebox" required="true"/></td>
	 				<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
	 				<td>联系电话：</td>
	 				<td><input type="text" id="phone" name="phone" style="width:150px;" class="easyui-validatebox" required="true"/></td>
	 			</tr>
	 			<tr>
	 				<td>联系地址：</td>
	 				<td colspan="4" style="text-align:left;">
	 					<input type="text" id="address" name="address" style="width: 99%;" class="easyui-validatebox" required="true" />
	 				</td>
	 			</tr>
	 		</table>
	 	</form>
	</div>
	
	<div id="dlg2" class="easyui-dialog" style="width: 600px;height:260px;padding: 10px 20px"
	  closed="true" buttons="#dlg-buttons2">
	 	<form id="fm2" method="post">
	 		<table cellspacing="8px" style="text-align:right;">
	 			<tr>
	 				<td>真实姓名：</td>
	 				<td><input type="text" id="trueName2" name="trueName" style="width:150px;" class="easyui-validatebox" required="true"/></td>
	 				<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
	 				<td>身&nbsp;份&nbsp;证：</td>
	 				<td><input type="text" id="idCardNo2" name="idCardNo" style="width:150px;" class="easyui-validatebox" required="true"/></td>
	 			</tr>
	 			<tr>
	 				
	 				<td>用&nbsp;户&nbsp;名：</td>
	 				<td><input type="text" id="username2" name="username" style="width:150px;" class="easyui-validatebox" required="true"/></td>
	 				<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
	 				<td>管&nbsp;理&nbsp;员：</td>
	 				<td style="text-align:left;">
	 					<input id="postId1" class="easyui-checkbox" type="radio" name="postId" value="admin" panelHeight="auto"> 是
	 					&nbsp;&nbsp;
        				<input id="postId0" class="easyui-checkbox" type="radio" name="postId" value="common" panelHeight="auto"> 否
	 				</td>
	 			</tr>
	 			<tr>
	 				<td>密&nbsp;&nbsp;&nbsp;&nbsp;码：</td>
	 				<td><input type="password" id="password2" name="password" style="width:150px;" class="easyui-validatebox" required="true"/></td>
	 				<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
	 				<td>性&nbsp;&nbsp;&nbsp;&nbsp;别：</td>
	 				<td style="text-align:left;">
	 					<input id="gender1" class="easyui-radio" type="radio" name="gender" value="男" panelHeight="auto"> 男
	 					&nbsp;&nbsp;
        				<input id="gender0" class="easyui-radio" type="radio" name="gender" value="女" panelHeight="auto"> 女
	 				</td>
	 			</tr>
	 			<tr>
	 				<td>工&nbsp;&nbsp;&nbsp;&nbsp;号：</td>
	 				<td><input type="text" id="jobNumber2" name="jobNumber" style="width:150px;" class="easyui-validatebox" required="true"/></td>
	 				<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
	 				<td>联系电话：</td>
	 				<td><input type="text" id="phone2" name="phone" style="width:150px;" class="easyui-validatebox" required="true"/></td>
	 			</tr>
	 			<tr>
	 				<td>联系地址：</td>
	 				<td colspan="4" style="text-align:left;">
	 					<input type="text" id="address2" name="address" class="easyui-validatebox" required="true" style="width: 99%;"/>
	 					<input type="hidden" id="postName2" name="postName" required="true"/>
	 				</td>
	 			</tr>
	 		</table>
	 	</form>
	</div>
	
	<div id="dlg-buttons">
		<a href="javascript:addUser()" class="easyui-linkbutton" iconCls="icon-ok">保存</a>
		<a href="javascript:closeUserDialog()" class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
	</div>
	
	<div id="dlg-buttons2">
		<a href="javascript:updateUser()" class="easyui-linkbutton" iconCls="icon-ok">保存</a>
		<a href="javascript:closeUpdateUserDialog()" class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
	</div>
</body>
</html>