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
<title>温湿度曲线</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/others/easyui/jquery-easyui-1.3.3/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/others/easyui/jquery-easyui-1.3.3/themes/icon.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/others/easyui/jquery-easyui-1.3.3/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/others/easyui/jquery-easyui-1.3.3/jquery.easyui.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/others/easyui/jquery-easyui-1.3.3/locale/easyui-lang-zh_CN.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/others/ECharts/echarts.min.js"></script>


<script type="text/javascript">

        // 显示图表。
        function loadLineCharts(){
        	// 基于准备好的dom，初始化echarts实例
			var myChart = echarts.init(document.getElementById('lineCharts'));
			var names=[];    //时间节点数组（放X轴坐标值）
    		var wdValues=[];    //温度值数组（放Y坐标值）
    		var sdValues=[];    //温度值数组（放Y坐标值）
			$.ajax({
				type : "post",
				async : true, 
				url : "${pageContext.request.contextPath }/charts/createLineCharts.html",
				data : {startDatetime:$("#startDatetime").datetimebox('getValue'),endDatetime:$("#endDatetime").datetimebox('getValue')},
				dataType : "json",
 		        success : function(result) {
		            //请求成功时执行该函数内容，result即为服务器返回的json对象
		            if (result) {
		                for(var i=0;i<result.length;i++){
		                	var date = new Date(parseInt(result[i].saveDatetime, 10));
							var month = date.getMonth() + 1 < 10 ? "0" + (date.getMonth() + 1) : date.getMonth() + 1;
							var currentDate = date.getDate() < 10 ? "0" + date.getDate() : date.getDate();
							var hours = date.getHours() < 10 ? "0" + date.getHours() : date.getHours();
							var minutes = date.getMinutes() < 10 ? "0" + date.getMinutes() : date.getMinutes();
							var seconds = date.getSeconds() < 10 ? "0" + date.getSeconds() : date.getSeconds();
							var week = date.getDay();
							//获取当前星期X(0-6,0代表星期天)
							if(week == 0) week="星期日"
							if(week == 1) week="星期一"
							if(week == 2) week="星期二"
							if(week == 3) week="星期三"
							if(week == 4) week="星期四"
							if(week == 5) week="星期五"
							if(week == 6) week="星期六"
		                    names.push(date.getFullYear() + "-" + month + "-" + currentDate + "\n" + week + "\n" + + hours + ":" + minutes + ":" + seconds);    //挨个取出时间节点并填入数组
		                }
		                for(var i=0;i<result.length;i++){
		                    wdValues.push(result[i].wdValue);    //挨个取出温度并填入数组
		                }
		                for(var i=0;i<result.length;i++){
		                    sdValues.push(result[i].sdValue);    //挨个取出湿度并填入数组
		                }
// 		                myChart.hideLoading();    //隐藏加载动画
 		                myChart.setOption({        //加载数据图表
 		                	title: {
					        text: '温湿度曲线'
						    },
						    tooltip: {
						        trigger: 'axis'
						    },
						    legend: {
						        data: ['温度', '湿度']
						    },
						    grid: {
						        left: '3%',
						        right: '4%',
						        bottom: '3%',
						        containLabel: true
						    },
						    toolbox: {
						        feature: {
						            saveAsImage: {}
						        }
						    },
						    xAxis: {
						        type: 'category',
						        boundaryGap: false,
						        data: names
						    },
						    yAxis: {
						        type: 'value'
						    },
						    series: [
						        {
						            name: '温度',
						            type: 'line',
						            data: wdValues
						        },
						        {
						            name: '湿度',
						            type: 'line',
						            data: sdValues
						        }
						    ]
		                });
		             }
		        },
		        error: function(errorMsg) {
		            //请求失败时执行该函数
		            alert("图表请求数据失败!");
// 		            myChart.hideLoading();
				}
			});
			$("#lineChartsDlg").dialog("open").dialog("setTitle","温湿度曲线");
        }
                
        function searchLineCharts(){
        	var s = $("#startDatetime").datetimebox('getValue');
        	var e = $("#endDatetime").datetimebox('getValue');
        	if(s==null && e!=null){
        		$.messager.alert("系统提示","<font size='3' color='green'>请选择查询起始时间！<font>");
				return;
        	}
        	$("#dg").datagrid('load',{
        		"startDatetime":s,
        		"endDatetime":e
        	});
        }
        
        function closelineChartsDlg(){
			$("#lineChartsDlg").dialog("close");
		}
		
		formatterStartDate = function (date) {
			var day = date.getDate() > 9 ? date.getDate() : "0" + date.getDate();
			var month = (date.getMonth() + 1) > 9 ? (date.getMonth() + 1) : "0" + (date.getMonth() + 1);
			var hor = date.getHours()-4;
			var min = date.getMinutes();
			var sec = date.getSeconds();
			return date.getFullYear() + '-' + month + '-' + day+" "+hor+":"+min+":"+sec;
		};
		
		formatterEndDate = function (date) {
			var day = date.getDate()+1 > 9 ? date.getDate()+1 : "0" + date.getDate()+1;
			var month = (date.getMonth() + 1) > 9 ? (date.getMonth() + 1) : "0" + (date.getMonth() + 1);
			return date.getFullYear() + '-' + month + '-' + day+" "+"00"+":"+"00"+":"+"00";
		};
		
		$(function(){
		 	$('#startDatetime').datetimebox('setValue', formatterStartDate(new Date()));
		 	$('#endDatetime').datetimebox('setValue', formatterEndDate(new Date()));
		});
        
</script>
</head>
<body style="margin:1px;">
	<div id="tb" style="padding-bottom:5px; padding-top:5px; ">
		<div>
			<label>起始时间：</label>
			<input type="text" class="easyui-datetimebox" value="" onkeydown="if(event.keyCode==13) searchLineCharts()" id="startDatetime">
			&nbsp;&nbsp;&nbsp;&nbsp;
			<label>截止时间：</label>
			<input type="text" class="easyui-datetimebox" value="" onkeydown="if(event.keyCode==13) searchLineCharts()" id="endDatetime">
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<a href="javascript:searchLineCharts()" class="easyui-linkbutton" iconCls="icon-search" plain="true" style="outline: none">搜索</a>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<a href="javascript:loadLineCharts()" class="easyui-linkbutton" iconCls="icon-search" plain="true" style="outline: none">查看变化曲线</a>
		</div>
	</div>
	
	<table id="dg" title="温湿度数据" class="easyui-datagrid"
	 fitColumns="true" pagination="true" rownumbers="true" 
	 url="${pageContext.request.contextPath }/charts/loadWsdData.html" fit="true" toolbar="#tb" striped="true">
	 <thead>
	 	<tr>
	 		<th field="devId" width="50" align="center">设备编号</th>
	 		<th field="devArea" width="50" align="center">设备区域</th>
	 		<th field="wdValue" width="80" align="center">温度值/℃</th>
	 		<th field="sdValue" width="50" align="center">湿度值/%</th>
	 		<th field="saveDatetime" width="80" align="center">保存时间</th>
	 	</tr>
	 </thead>
	</table>
	
	<div id="lineChartsDlg" class="easyui-dialog" onkeydown="if(event.keyCode==13) closelineChartsDlg()" style="width: 810px;height:500.58px;padding: 10px 20px;text-align:center;overflow-y: hidden;"
	  closed="true" buttons="#dlg-buttons">
	 	<div id="lineCharts" style="width: 700px;height:432px;margin-left:20px"></div>
	</div>
	<div id="dlg-buttons">
		<a href="javascript:closelineChartsDlg()" class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
	</div>
	
</body>
</html>