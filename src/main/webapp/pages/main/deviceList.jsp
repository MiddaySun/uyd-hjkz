<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>设备信息列表</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/others/easyui/jquery-easyui-1.3.3/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/others/easyui/jquery-easyui-1.3.3/themes/icon.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/others/easyui/jquery-easyui-1.3.3/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/others/easyui/jquery-easyui-1.3.3/jquery.easyui.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/others/easyui/jquery-easyui-1.3.3/locale/easyui-lang-zh_CN.js"></script>

<script type="text/javascript">
	
	var url;
	
	function searchData(){
		$("#dg").datagrid('load',{
			"cName":$("#s_trueName").val()
		});
	}
	
	$(function(){
		$('#s_typeId').combobox({   
	         onChange:function(){  
	        	 $("#dg").datagrid('load',{
	     			"typeId":$('#s_typeId').combobox('getValue')
	     		});
	         }
	    })   
	});
	
	function deleteData(){
		var selectedRows=$("#dg").datagrid('getSelections');
		if(selectedRows.length==0){
			$.messager.alert("系统提示","<font size='3' color='green'>请选择要删除的数据！<font>");
			return;
		}
		var strIds=[];
		for(var i=0;i<selectedRows.length;i++){
			strIds.push(selectedRows[i].id);
		}
		var ids=strIds.join(",");
		$.messager.confirm("系统提示","您确认要删除这<font color=red>"+selectedRows.length+"</font>条数据吗？",function(r){
			if(r){
				$.post("${pageContext.request.contextPath }/device/delete.html",{ids:ids},function(result){
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
							msg:"<font size='3' color='green'>删除失败！</font>",
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
	
	
	function openAddDialog(){
		$("#dlg").dialog("open").dialog("setTitle","添加设备信息");
		url = "${pageContext.request.contextPath }/device/add.html";
	}
	
	
	function addMedicine(){
		$("#fm").form("submit",{
			url:url,
			onSubmit:function(){
				if($("#typeId").combobox("getValue")==""){
					$.messager.alert("系统提示","<font size='3' color='green'>请选择对应的设备类别!<font>");
					return false;
				}
				if($("#productDate").datebox("getValue")==""){
					$.messager.alert("系统提示","<font size='3' color='green'>请选择生产日期！<font>");
					return false;
				}
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
						msg:"<font size='3' color='green'>添加成功！</font>",
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
						msg:"<font size='3' color='green'>添加失败！</font>",
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
	
	function updateMedicine(){
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
						msg:"<font size='3' color='green'>修改成功！</font>",
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
						msg:"<font size='3' color='green'>修改失败！</font>",
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
	
	function openModifyDialog(){
		var selectedRows=$("#dg").datagrid('getSelections');
		if(selectedRows.length!=1){
			$.messager.alert("系统提示","<font size='3' color='green'>请选择一条要编辑的数据！<font>");
			return;
		}
		var row=selectedRows[0];
		$("#dlg2").dialog("open").dialog("setTitle","编辑设备信息");
		$("#cName2").val(row.cName);
		$("#eName2").val(row.eName);
		$("#price2").val(row.price);
		$("#typeId2").combobox("setValue",row.type.id);
		$("#describle2").val(row.describle);
		$("#manufacturer2").val(row.manufacturer);
		$("#safeDate2").val(row.safeDate);
		$("#standard2").val(row.standard);
		$("#nums2").val(row.nums);
		$("#productDate2").datebox("setValue", row.productDate);
		url="${pageContext.request.contextPath }/device/update.html?id="+row.id;
	}
	
	function resetValue(){
		$("#cName").val("");
		$("#eName").val("");
		$("#price").val("");
		$("#typeId").combobox("setValue","");
		$("#describle").val("");
		$("#manufacturer").val("");
		$("#safeDate").val("");
		$("#standard").val("");
		$("#nums").val("");
		$("#productDate").datebox("setValue", "");
	}
	
	function closeDeviceDialog(){
		$("#dlg").dialog("close");
		resetValue();
	}
	
	function closeUpdateDeviceDialog(){
		$("#dlg2").dialog("close");
	}
</script>
</head>
<body style="margin:1px;">
	<table id="dg" title="设备列表" class="easyui-datagrid"
	 fitColumns="true" pagination="true" rownumbers="true" 
	 url="${pageContext.request.contextPath }/deviceInfo/findList.html" fit="true" toolbar="#tb">
	 <thead>
	 	<tr>
	 		<th field="cb" checkbox="true" align="center"></th>
	 		<th field="devId" width="30" align="center">编号</th>
	 		<th field="devName" width="120" align="center">名称</th>
	 		<th field="devManufacture" width="100" align="center">生产商</th>
	 		<th field="devModelNumber" width="100" align="center">型号</th>
	 		<th field="devCategory" width="70" align="center">类别</th>
	 		<th field="devInterface" width="140" align="center">接口信息</th>
	 		<th field="devState" width="50" align="center">状态</th>	 		
	 		<th field="devLastStateTime" width="80" align="center">最后更新状态日期</th>
<!-- 	 		<th field="unitId" width="50" align="center" >机构编码</th> -->
	 	</tr>
	 </thead>
	</table>
	<div id="tb" style="padding-bottom:5px; padding-top:5px; ">
		<div>
			<a href="javascript:openAddDialog()" class="easyui-linkbutton" iconCls="icon-add" plain="true">添加</a>&nbsp;&nbsp;
			<a href="javascript:openModifyDialog()" class="easyui-linkbutton" iconCls="icon-edit" plain="true">修改</a>&nbsp;&nbsp;
			<a href="javascript:deleteData()" class="easyui-linkbutton" iconCls="icon-remove" plain="true">删除</a>&nbsp;&nbsp;
			<a href="javascript:searchData()" class="easyui-linkbutton" iconCls="icon-search" plain="true" style="outline: none">搜索</a>
			<input type="text" id="s_trueName" style="width:200px;" size="20" onkeydown="if(event.keyCode==13) searchData()" placeholder="请输入您要查找设备名称"/>
		</div>
<!-- 		<div style="margin-left:476px;margin-top:-25px;"> -->
<!-- 			<select class="easyui-combobox" id="s_typeId" name="typeId" style="width: 143px;" editable="false" panelHeight="auto"> -->
<!-- 	 			<option value="">- - - - -全部- - - - -</option> -->
<%-- 	 			<c:forEach var="type" items="${typeList }"> --%>
<%-- 	 				<option value="${type.id }">${type.cTypeName }</option> --%>
<%-- 	 			</c:forEach> --%>
<!-- 	 		</select> -->
<!-- 		</div> -->
	</div>
	
	<div id="dlg" class="easyui-dialog" style="width: 570px;height:300px;padding:10px 20px"
	  closed="true" buttons="#dlg-buttons">
	 	<form id="fm" method="post">
	 		<table cellspacing="8px">
	 			<tr>
	 				<td>设备编号：</td>
	 				<td><input type="text" id="devId" name="devId" class="easyui-validatebox" required="false"/></td>
	 				<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
	 				<td>设备名称：</td>
	 				<td><input type="text" id="devName" name="devName" class="easyui-validatebox" required="true"/></td>
	 			</tr>
	 			<tr>
	 				<td>生产商：</td>
	 				<td><input type="text" id="devManufacture" name="devManufacture" class="easyui-validatebox" required="true"/></td>
	 				<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
	 				<td>型号：</td>
	 				<td><input type="text" id="devModelNumber" name="devModelNumber" class="easyui-validatebox" required="true"/></td>
	 			</tr>
	 			<tr>
	 				<td>类别：</td>
	 				<td><input type="text" id="devCategory" name="devCategory" class="easyui-validatebox" required="false"/></td>
	 				<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
	 				<td>接口信息：</td>
	 				<td>
	 				<input type="text" id="devInterface" name="devInterface" class="easyui-validatebox" required="false"/>
<!-- 	 					<select class="easyui-combobox" id="devInterface" name="devInterface" style="width: 143px;" editable="false" panelHeight="auto"> -->
<!-- 	 						<option value="">---请选择药品类别---</option> -->
<%-- 				 			<c:forEach var="type" items="${typeList }"> --%>
<%-- 				 				<option value="${type.id }">${type.cTypeName }</option> --%>
<%-- 				 			</c:forEach> --%>
<!-- 	 					</select> -->
	 				</td>
	 			</tr>
	 			<tr>
	 				<td>状态：</td>
	 				<td><input type="text" id="devState" name="devState" class="easyui-validatebox" required="false"/></td>
	 				<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
	 				<td>更新日期：</td>
	 				<td><input type="text" id="devLastStateTime" name="devLastStateTime" class="easyui-validatebox"  required="false"/></td>
	 			</tr>
	 		</table>
	 	</form>
	</div>
	
	<div id="dlg2" class="easyui-dialog" style="width: 570px;height:300px;padding: 10px 20px"
	  closed="true" buttons="#dlg-buttons2">
	 	<form id="fm2" method="post">
	 		<table cellspacing="8px">
		 		<tr>
	 				<td>设备编号：</td>
	 				<td><input type="text" id="devId2" name="devId" class="easyui-validatebox" required="false"/></td>
	 				<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
	 				<td>设备名称：</td>
	 				<td><input type="text" id="devName2" name="devName" class="easyui-validatebox" required="true"/></td>
	 			</tr>
	 			<tr>
	 				<td>生产商：</td>
	 				<td><input type="text" id="devManufacture2" name="devManufacture" class="easyui-validatebox" required="true"/></td>
	 				<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
	 				<td>型号：</td>
	 				<td><input type="text" id="devModelNumber2" name="devModelNumber" class="easyui-validatebox" required="true"/></td>
	 			</tr>
	 			<tr>
	 				<td>类别：</td>
	 				<td><input type="text" id="devCategory2" name="devCategory" class="easyui-validatebox" required="false"/></td>
	 				<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
	 				<td>接口信息：</td>
	 				<td>
	 					<input type="text" id="devInterface2" name="devInterface" class="easyui-validatebox" required="false"/>
<!-- 	 					<select class="easyui-combobox" id="typeId2" name="typeId" style="width: 143px;" editable="false" panelHeight="auto"> -->
<!-- 	 						<option value="">---请选择药品类别---</option> -->
<%-- 				 			<c:forEach var="type" items="${typeList }"> --%>
<%-- 				 				<option value="${type.id }">${type.cTypeName }</option> --%>
<%-- 				 			</c:forEach> --%>
<!-- 	 					</select> -->
	 				</td>
	 			</tr>
	 			<tr>
	 				<td>状态：</td>
	 				<td><input type="text" id="devState2" name="devState" class="easyui-validatebox"  required="false"/></td>
	 				<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
	 				<td>更新日期：</td>
	 				<td><input type="text" id="devLastStateTime2" name="devLastStateTime" class="easyui-validatebox"  required="false"/></td>
	 			</tr>
	 			
	 		</table>
	 	</form>
	</div>
	
	<div id="dlg-buttons">
		<a href="javascript:addDevice()" class="easyui-linkbutton" iconCls="icon-ok">保存</a>
		<a href="javascript:closeDeviceDialog()" class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
	</div>
	
	<div id="dlg-buttons2">
		<a href="javascript:updateDevice()" class="easyui-linkbutton" iconCls="icon-ok">保存</a>
		<a href="javascript:closeUpdateDeviceDialog()" class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
	</div>
</body>
</html>