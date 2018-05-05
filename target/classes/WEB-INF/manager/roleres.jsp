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
		var roleid=0;
			$(function(){
			/***start easyui 获得实心选中节点的扩展方法***/
			 $.extend($.fn.tree.methods,{
				        getCheckedExt: function(jq){//扩展getChecked方法,使其能实心节点也一起返回
				            var checked = $(jq).tree("getChecked");
				            var checkbox2 = $(jq).find("span.tree-checkbox2").parent();
				            $.each(checkbox2,function(){
				                var node = $.extend({}, $.data(this, "tree-node"), {
				                    target : this
				                });
				                checked.push(node);
				            });
				            return checked;
				        },
					    });
			/***end easyui 获得实心选中节点的扩展方法***/
			//异步树
				/*$('#tt').tree({
                data:'resource/ushouquan.do',
                onLoadSuccess:function(){ //调用expandAll方法 
                   $("#tt").tree('expandAll');  
        		}
             	 });*/
             	 
             	 //查询--查询按钮事件 
			$('#serachbtn').click(function(){
				$('#rolelist').datagrid('load' ,{
						rolename: $('#searrolename').val(),
						rolestate: $('#searrolestate').combobox('getValue'),
						rolecode:$('#searrolecode').val()
					});
				});
			//查询--清空按钮事件
			$('#clearbtn').click(function(){
						$('#mysearch').form('clear');
						$('#rolelist').datagrid('load' ,{});
					});
		});
</script>
	</head>
	<body>
  <!-- start 是否关联选中 -->
	<!-- <div style="margin:10px 0">
		<input type="checkbox" checked onchange="$('#tt').tree({cascadeCheck:$(this).is(':checked')})">CascadeCheck
		<input type="checkbox"  onchange="$('#tt').tree({onlyLeafCheck:$(this).is(':checked')})">OnlyLeafCheck
	</div>  --> 
  <!-- end 是否关联选中 -->
  	<!-- S 职务区 -->
  	<div style="float: left;">
  	<div class="easyui-panel" style="padding:5px;height: 500px;width: 750px;float: left;" title="职务区">
		<table class="easyui-datagrid"  id="rolelist" data-options="rownumbers:true,singleSelect:true,url:'resource/getRoles.do',method:'post',toolbar:'#tb', 
							fit:true,
							rowStyler: function(index ,record){
								 if(record.rolestate ==0){
									 return 'background:yellow';
									 };
								 },loadMsg: '数据加载中......',
								 striped: true,onDblClickRow:onDbClickRow">
						<thead>
							<tr>
								<th data-options="field:'rolecode',width:80,editor:'text',require:true">职务编码</th>
								<th data-options="field:'rolename',width:80,editor:'text'">职务名称</th>
								<th data-options="field:'rolestate',width:80,formatter:function(value,record,index){if(value==1)return '正常';else return '停用';},editor:{type:'checkbox',options:{on:'1',off:'0'}}">职务状态</th>
								<th data-options="field:'roledesc',align:'center',width:350,editor:'text'">职务描述</th>
								<th data-options="field:'operate',width:80,align:'center',formatter:rowformater">权限</th>	
								<input type="hidden" id="Hroleid" />
			<script type="text/javascript">  
					function rowformater(value, row, index) {  
						return "<a href='javascript:getinfo("+index+");' target='_self' style='color:blue;'> " + "查看" + "</a>";//_top,  
							}  
					 function getinfo(index) {
						  var row = $('#rolelist').datagrid('getData').size[index];
						  var act="";
						  var img=$("#nodata").hide();
						  	roleid=row.roleid;
						  if(roleid==undefined){
						  		roleid=${sessionScope.roleid};
						  		act="newsq";
						  		}
							/*S  权限菜单生成*/
							$.ajax({
				             	 	type:'post',
									url:'resource/ushouquan.do?roleid='+roleid+"&act="+act,
									success:function(result) {
										$("#Hroleid").val(roleid);
										$('#tt').tree({
				             			checkbox: true,
										data: result,
										cascadeCheck:true,
										onLoadSuccess:function(){
												//调用expandAll方法 
							                   //$("#tt").tree('expandAll');  
							        		}
										});
									}
								});
							/*E  权限菜单生成*/
						}
						function btnreset() {
							$('a[name=btns]').each(function(){
								$(this).css("display","none");							
							});
						}
   			 </script>  
							</tr>
						</thead>
					</table>
					<!-- S 搜索域  -->
						<div id="tb" style="padding:5px;height:auto">
							<div>
								<form method="post" id="mysearch">
								职务名称：<input type="text" id="searrolename" name="searrolename"  value="" class="easyui-textbox" style="width:60px;"/>
								职务简码：<input type="text" id="searrolecode" name="searrolecode"  value="" class="easyui-textbox" style="width:60px;"/>
<!--								办卡日期: <input class="easyui-datebox" style="width:80px" id="searstarttime" name="searstarttime">-->
<!--								有效日期: <input class="easyui-datebox" style="width:80px" name="searendtime">-->
								职务状态: 
								<select class="easyui-combobox" panelHeight="auto" style="width:100px" name="searrolestate" id="searrolestate">
									<option value="">全部</option>
									<option value="1">正常</option>
									<option value="0">停用</option>
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
	</div>
  	<!-- E 职务区 -->
	<!-- S 权限区 -->
	<div>
	<div class="easyui-panel" style="padding:5px;width: 150px;height:500px;float: left;" title="权限区">
		<div style="height: 420px;" >
		<ul id="tt" class="easyui-tree" style=""></ul><img alt="没有数据" src="images/no-data.png" style="padding-top: 150px;padding-left: 13px;" id="nodata"  align="middle">
		</div>
		<hr>
		<a href="javascript:void(0);" class="easyui-linkbutton" onclick="getChecked();" style="width: 100px;text-align:center;margin-left: 25px;">授权</a> 
	</div>
	</div>
	<!-- E 权限区 -->
<script type="text/javascript">
/*S 授权 */
		function getChecked(){
			var Hroleid=$("#Hroleid").val();
				if(Hroleid!=""&&Hroleid!=null){
					$.messager.confirm('操作提示', '确定授予权限？', function(r){
							if (r){
						//获得选中的节点,
						// var checks = $("#tt").tree("getCheckedExt");
						var checks = $("#tt").tree("getChecked");
						var nodes = $('#tt').tree('getChecked','indeterminate');  
						//声明实心点arry1数组存储选中实心节点的id。
						var arry1 = [];
						//arry1赋值
						$.each(nodes,function(){
						    arry1.push(this.id);
						  });
						//声明子菜单arry数组存储选中子菜单节点的id。
						var arry2 = [];
						//arry赋值
						$.each(checks,function(){
						    arry2.push(this.id);
						  });
						  //Id提交给后台
						   $.post("resource/saveupdate.do?arry="+arry2.concat(arry1)+"&roleid="+Hroleid, function(result) {  
			                    if (result.msg=="yes") {
			                        $.messager.alert("系统提示", "授权成功");
			                    } else {
			                        $.messager.alert("系统提示", "操作失败！");
			                    }
			                }, "json");
						}
					});		
				}
				else{
					$.messager.alert("操作提示", "请选择要授权职务");}
				}
/*E 授权*/
/*S CRUD*/
var editIndex = undefined;
		function endEditing(){
			if (editIndex == undefined){return true;}
			if ($('#rolelist').datagrid('validateRow', editIndex)){
				$('#rolelist').datagrid('endEdit', editIndex);
				$('#rolelist').datagrid('refreshRow', editIndex); 
				var roleinfo=$('#rolelist').datagrid('getSize')[editIndex];
				var rolename=roleinfo.rolename;
				var roledesc=roleinfo.roledesc;
				var rolestate=roleinfo.rolestate;
				var rolecode=roleinfo.rolecode;
				var roleid=roleinfo.roleid;
						 $.ajax({
									type: 'post' ,
									url: 'resource/updateRole.do' ,
									cache:false ,
									data:{rolename:rolename,roledesc:roledesc,rolecode:rolecode,rolestate:rolestate,roleid:roleid},
									success:function(result){
											//3 提示信息
											$.messager.show({
												title:result.status , 
												msg:result.msg,
												showType:'fade',
											});
									$('#rolelist').datagrid('reload'); 
									},
									error:function(){
										$.meesager.show({
											title:'出错' , 
											msg:'操作失败'
										});
									}
								});
								//2刷新datagrid 
				$('#rolelist').datagrid('reload');
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
					$('#rolelist').datagrid('selectRow', index).datagrid('beginEdit', index);
					/*S  前台和注册用户不可编辑*/
					var rolecode=$('#rolelist').datagrid('getSize')[index]['rolecode'];
				 	roleid=$('#rolelist').datagrid('getSize')[index].roleid;
					if(rolecode=="ZCYH"||rolecode=="JDQT"){
						// 得到单元格对象,index指哪一行,field跟定义列的那个一样
	                    var cellEdit = $('#rolelist').datagrid('getEditor', {index:index,field:'rolecode'});
	                    var $input = cellEdit.target; // 得到文本框对象
	                    //$input.val('aaa'); // 设值
	                    $input.prop('readonly',true); // 设值只读
						}
					/*E  前台和注册用户不可编辑*/
					editIndex = index;
				} else {
					$('#rolelist').datagrid('selectRow', editIndex);
				}
			}
		}
	
		function append(){
			if (endEditing()){
				$('#rolelist').datagrid('appendRow',{
									rolestate:1
									});
				editIndex = $('#rolelist').datagrid('getSize').length-1;
				$('#rolelist').datagrid('selectRow', editIndex)
						.datagrid('beginEdit', editIndex);
			}
		}
		function removeit(){
			$.messager.confirm('警告', '确定删除此职务？', function(r){
							if(r){
								if(editIndex == undefined){return;}
								$.post("resource/deleteRole.do",{roleid:roleid},function(result){
							   		 $.messager.show({
													title:result.status , 
													msg:result.msg,
														});
										  });
								$('#rolelist').datagrid('cancelEdit', editIndex).datagrid('deleteRow', editIndex);
								editIndex = undefined;
								}
							});
			
		}
		function accept(){
			if (endEditing()){
				$('#rolelist').datagrid('acceptChanges');
			}
		}
		function reject(){
			$('#rolelist').datagrid('rejectChanges');
			editIndex = undefined;
		}
		
/*E CRUD*/
	</script>
	<div style="margin:20px 0;">
	</div>
		
  </body>
</html>
