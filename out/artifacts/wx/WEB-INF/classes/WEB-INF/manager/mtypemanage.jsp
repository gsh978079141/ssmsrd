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
						typename: $('#seartypename').val(),
						state: $('#searstate').combobox('getValue'),
						sprice: $('#searsprice').combobox('getValue')
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
		<table class="easyui-datagrid"  id="typelist" data-options="rownumbers:true,singleSelect:true,url:'mem/gettype.do',method:'post',toolbar:'#tb', 
							fit:true,pagination: true , 
							pageSize: 5 ,
							pageList:[5,10,15,20,50] ,
							rowStyler: function(index ,record){
								 if(record.state ==0){
									 return 'background:yellow';
									 };
								 },loadMsg: '数据加载中......',
								 striped: true,onDblClickRow:onDbClickRow">
						<thead>
							<tr>
								<th data-options="field:'typename',width:80,editor:'text',require:true">会员名称</th>
								<th data-options="field:'cardfee',width:80,align:'center',editor:'text',formatter:function(value,row){if(value!=null&&value!='')return '￥'+value;}">卡费</th>	
								<th data-options="field:'roomrate',width:80,align:'center',editor:'text'">房费折扣</th>	
								<th data-options="field:'goodrate',width:80,align:'center',editor:'text'">商品折扣</th>
								<th data-options="field:'uppoints',width:80,editor:'text',editor:'text'">升级所需积分</th>
								<th data-options="field:'overdue',width:80,editor:'text',editor:'text'">可逾期次数</th>
								<th data-options="field:'pointsrule',width:60,editor:'text',editor:'text'">积分规则</th>
								<th data-options="field:'sprice',width:80,align:'center',formatter:function(value,record,index){if(value==1)return '享受';else return '不享受';},editor:{type:'checkbox',options:{on:'1',off:'0'}}">特价房折扣</th>
								<th data-options="field:'state',width:80,formatter:function(value,record,index){if(value==1)return '正常';else return '停用';},editor:{type:'checkbox',options:{on:'1',off:'0'}}">是否启用</th>
								<th data-options="field:'remark',width:360,align:'center',editor:'text'">备注信息</th>	
							</tr>
						</thead>
					</table>
					<input type="hidden" id="Htypeid" />
					<!-- S 搜索域  -->
						<div id="tb" style="padding:5px;height:auto">
							<div>
								<form method="post" id="mysearch">
								会员名称：<input type="text" id="seartypename" name="seartypename"  value="" class="easyui-textbox" style="width:60px;"/>
								会员状态: 
								<select class="easyui-combobox" panelHeight="auto" style="width:100px" name="searstate" id="searstate">
									<option value="">全部</option>
									<option value="1">正常</option>
									<option value="0">停用</option>
								</select>
								特价房折扣: 
								<select class="easyui-combobox" panelHeight="auto" style="width:100px" name="searsprice" id="searsprice">
									<option value="">全部</option>
									<option value="1">享受</option>
									<option value="0">不享受</option>
								</select>
								<a id="serachbtn"  class="easyui-linkbutton" iconCls="icon-search">查询</a>
								<a id="clearbtn" class="easyui-linkbutton" >清空</a>
								</form>
								<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true" onclick="append()">新增</a>
								<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true" onclick="removeit()">删除</a>
								<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-save',plain:true" onclick="accept()">保存</a>
								<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-undo',plain:true" onclick="reject()">撤销</a>
							</div>
						</div>
					<!-- E 搜索域  -->
	</div>
<script type="text/javascript">
/*S CRUD*/
var editIndex = undefined;
		function endEditing(){
			if (editIndex == undefined){return true;}
			if ($('#typelist').datagrid('validateRow', editIndex)){
				$('#typelist').datagrid('endEdit', editIndex);
				$('#typelist').datagrid('refreshRow', editIndex); 
				var typeinfo=$('#typelist').datagrid('getSize')[editIndex];
						 $.ajax({
									type: 'post' ,
									url: 'mem/saveupdate_memtype.do' ,
									cache:false ,
									data:typeinfo,
									success:function(result){
											//3 提示信息
											$.messager.show({
												title:result.status , 
												msg:result.msg,
												showType:'fade',
											});
									$('#typelist').datagrid('reload'); 
									},
									error:function(){
										$.meesager.show({
											title:'出错' , 
											msg:'操作失败'
										});
									}
								});
								//2刷新datagrid 
				$('#typelist').datagrid('reload');
				editIndex = undefined;
				return true;
			} else {
				return false;
			}
		}
		function onDbClickRow(index){
			if (editIndex != index){
				reject();
				if (endEditing()){
					$('#typelist').datagrid('selectRow', index).datagrid('beginEdit', index);
					editIndex = index;
					typeid=$('#typelist').datagrid('getSize')[editIndex].id;
				} else {
					$('#typelist').datagrid('selectRow', editIndex);
				}
			}
		}
	
		function append(){
			if (endEditing()){
				$('#typelist').datagrid('appendRow',{
									state:1
									});
				editIndex = $('#typelist').datagrid('getSize').length-1;
				$('#typelist').datagrid('selectRow', editIndex)
						.datagrid('beginEdit', editIndex);
			}
		}
		function removeit(){
			if(editIndex == undefined){return;}
		$.messager.confirm('警告', '确定删除此会员类型？', function(r){
							if(r){
								$.post("mem/delete_memtype.do",{id:typeid},function(result){
							   		 $.messager.show({
													title:result.status , 
													msg:result.msg,
													timeout:350
														});
										  });
								$('#typelist').datagrid('cancelEdit', editIndex).datagrid('deleteRow', editIndex);
								editIndex = undefined;
								}
							});
			
		}
		function accept(){
			if (endEditing()){
				$('#typelist').datagrid('acceptChanges');
			}
		}
		function reject(){
			$('#typelist').datagrid('rejectChanges');
			editIndex = undefined;
		}
		
/*E CRUD*/
	</script>
	<div style="margin:20px 0;">
	</div>
		
  </body>
</html>
