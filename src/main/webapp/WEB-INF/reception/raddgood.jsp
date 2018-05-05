<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <title>main</title>
	<link rel="stylesheet" type="text/css" href="css/common.css" />
	<script type="text/javascript" src="js/jquery.min.js"></script>
	<link rel="stylesheet" type="text/css" href="js/easyui/themes/bootstrap/easyui.css" />
	<link rel="stylesheet" type="text/css" href="js/easyui/themes/icon.css" />
	<script type="text/javascript" src="js/easyui/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="js/easyui/locale/easyui-lang-zh_CN.js"></script>
	<style type="text/css">
		hr{
			width: 85%;
			height:10px;border:none;border-top:10px groove skyblue;
		}
		.memdetail input{
			margin-left:5px;
		}
		#memdetail a{
			float:left;
			margin:  0 20px;
			width: 100px;
			height: 30px;
			background: skyblue;
			text-align: center;
		}
		#memdetail a label{
			font-size: 13px;
		}
		.hykxx{
		background-color:#EAEAEA; width: 550px;
		}
		.grxx{
		 background-color:#EAEAEA; width: 550px;
		
		}
		.infos{
			background-color: rgb(239,239,239);
			margin:  20px 10px;
			padding: 5px;
		    justify-content: space-around;	
		    text-align: center;
		    width: 450px;
		    	}
		 input{
			margin-left:15px;
			width: 80px;
			
		}
	</style>
	<script type="text/javascript">
		$(function(){
		$.post("room/getconsumpt.do",{roomid:${param.id}},function(data){
		var con=data.con;
			$("#roomnum").textbox('setValue',con.roomnum);
			$("#guestname").textbox('setValue',con.guestname);
			$("#starttime").textbox('setValue',con.starttime);
			$("#ordernum").textbox('setValue',con.ordernum);
			$("#conid").val(con.id);
			
		});
			//查询--查询按钮事件 
			$('#serachbtn').click(function(){
				$('#goodlist').datagrid('load' ,{
						spjm: $('#spjm').val(),
						sptype: $('#sptype').combobox('getValue')
					});
				});
			//查询--清空按钮事件
			$('#clearbtn').click(function(){
						$('#mysearch').form('clear');
						$('#goodlist').datagrid('load' ,{});
					});
		});
	
	</script>
  </head>
  
  
  <body>
  <input type="hidden" id="conid" name="conid">
  
  	<h2>财务入账</h2>	
  		<center>
  			<div id="divroominfo" class="infos" align="center">
				<label>房号:</label><input  name="roomnum" id="roomnum" readonly="readonly" class="easyui-textbox" value="">
				入住时间:<input  name="starttime" id="starttime" readonly="readonly" class="easyui-textbox" value="" style="width: 150px;"><br>
				入住人:<input  name="guestname" id="guestname" readonly="readonly" class="easyui-textbox" value="" >
				入账单号:<input  name="ordernum" id="ordernum" readonly="readonly" class="easyui-textbox" value="" style="width: 150px;">
				
			</div>	
			</center>
			<div style="400px;height: 450px;">
			<table class="easyui-datagrid" title="会员信息列表" id="goodlist" data-options="rownumbers:true,singleSelect:true,url:'room/goodlist.do',method:'post',toolbar:'#tb',pagination: true,
							pageSize: 10 ,
							pageList:[5,10,15,20,50] ,fit:true,loadMsg: '数据加载中......'">
						<thead>
							<tr>
								<th data-options="field:'id',width:80">商品编号</th>
								<th data-options="field:'spjm',width:80">商品简码</th>
								<th data-options="field:'spname',width:80">商品名称</th>
								<th data-options="field:'spprice',width:100,align:'right'">商品价格</th>
								<th data-options="field:'sptype',width:80">商品类别</th>
								<th data-options="field:'amount',width:80">剩余库存</th>
								<th data-options="field:'_operate',width:80,align:'center',formatter:rowformater">操作</th>	
								
			<script type="text/javascript">  
					function rowformater(value, row, index) {  
						return "<a href='javascript:addgood("+index+");' target='_self' style='color:blue;'> " + "入账" + "</a>";//_top,  
							}  
					 function addgood(index) {
						  var row = $('#goodlist').datagrid('getData').size[index];
						  	 	 $.messager.confirm("提示","确认入账"+row.spname+"？价格"+row.spprice , function (data){
														 if (data) {
															$.post("room/sureadd.do",{conid:$("#conid").val(),goodid:row.id},function(data){
																 $.messager.show({ 
															              title: '入账提示', 
															              msg: '已添加房间消费单，入账成功 ', 
															              showType: 'fade', 
															              timeout: 400, 
															              style: { 
															                right: '', 
															                bottom: ''
															              } 
															            }); 
																$("#goodlist").datagrid('reload');
																});
															}
															
												        });
						  						}
						  	
						  
						
   			 </script>  
							</tr>
						</thead>
					</table>
					 </div>
						<div id="tb" style="padding:5px;height:auto">
							<div>
								<form method="post" id="mysearch">
								<a ></a>
								商品简码：<input type="text" id="spjm" name="spjm"  value="" class="easyui-textbox" style="width:60px;"/>
								商品类别：
								<select class="easyui-combobox" panelHeight="auto" style="width:100px" name="sptype" id="sptype">
									<option value="">所有分类</option>
									<option value="饮料酒水">饮料酒水</option>
									<option value="餐券">餐券</option>
									<option value="客房服务">客房服务</option>
									<option value="其他">其他</option>
								</select>
								<a id="serachbtn"  class="easyui-linkbutton" iconCls="icon-search">查询</a>
								<a id="clearbtn" class="easyui-linkbutton" >清空</a>
								</form>
							</div>
						</div>
 </body>
</html>
