<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>极限星空酒店管理-后台管理</title>
  	<link rel="stylesheet" type="text/css" href="css/common.css" />
	<script type="text/javascript" src="js/jquery.min.js"></script>
	<link rel="stylesheet" type="text/css" href="js/easyui/themes/bootstrap/easyui.css" />
	<link rel="stylesheet" type="text/css" href="js/easyui/themes/icon.css" />
	<script type="text/javascript" src="js/easyui/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="js/easyui/locale/easyui-lang-zh_CN.js"></script>
	<script type="text/javascript">
		var typeid=0; 
			$(function(){
             	 //查询--查询按钮事件 
			$('#serachbtn').click(function(){
				$('#typelist').datagrid('load' ,{
						recnum: $('#searrecnum').val(),
						memnum: $('#searmemnum').val(),
						pay: $('#searpaymethod').combobox('getValue')
					});
				});
			//查询--清空按钮事件
			$('#clearbtn').click(function(){
						$('#mysearch').form('clear');
						$('#typelist').datagrid('load' ,{});
					});
		});
		
</script>
	</head>
	<body>
  	<div style="float: left;width: 100%;height: 95%;">
		<table class="easyui-datagrid"  id="typelist" data-options="rownumbers:true,singleSelect:true,url:'mem/getrclist.do',method:'post',toolbar:'#tb', 
							fit:true,pagination: true , 
							pageSize: 5 ,striped: true ,	
							pageList:[5,10,15,20,50] ,
							loadMsg: '数据加载中......',
								 striped: true">
						<thead>
							<tr>
								<th data-options="field:'recnum',width:180,align:'center'">充值单号</th>
								<th data-options="field:'memnum',width:80,align:'center'">会员卡号</th>
								<th data-options="field:'paymethod',width:80,align:'center',formatter:function(value,row){
							return row.paymethod.name;
						}">支付方式</th>	
								<th data-options="field:'recmoney',width:80,align:'center',formatter:function(value,row){if(value!=null&&value!='')return '￥'+value;}">充值金额</th>	
								<th data-options="field:'rectime',width:180,align:'center'">充值时间</th>
								<th data-options="field:'bookkeeper',width:80">操作员</th>
								<th data-options="field:'remark',width:360,align:'center'">备注信息</th>	
							</tr>
						</thead>
					</table>
					<input type="hidden" id="Htypeid" />
					<!-- S 搜索域  -->
						<div id="tb" style="padding:5px;height:auto">
							<div>
								<form method="post" id="mysearch">
								充值单号：<input type="text" id="searrecnum" name="searrecnum"  value="" class="easyui-textbox" style="width:160px;"/>
								会员卡号：<input type="text" id="searmemnum" name="searmemnum"  value="" class="easyui-textbox" style="width:80px;"/>
								支付方式: 
								<select class="easyui-combobox" panelHeight="auto" style="width:100px" name="searpaymethod" id="searpaymethod">
									<option value="0">全部</option>
									<option value="1">现金</option>
									<option value="5">信用卡</option>
									<option value="3">网上支付</option>
								</select>
								<a id="serachbtn"  class="easyui-linkbutton" iconCls="icon-search">查询</a>
								<a id="clearbtn" class="easyui-linkbutton" >清空</a>
								</form>
							</div>
						</div>
					<!-- E 搜索域  -->
	</div>

	<div style="margin:20px 0;">
	</div>
		
  </body>
</html>
