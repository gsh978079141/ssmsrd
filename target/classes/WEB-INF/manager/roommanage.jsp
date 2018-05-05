<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <title>roommanage</title>
	<link rel="stylesheet" type="text/css" href="css/common.css" />
	<script type="text/javascript" src="js/jquery.min.js"></script>
	<link rel="stylesheet" type="text/css" href="js/easyui/themes/bootstrap/easyui.css" />
	<link rel="stylesheet" type="text/css" href="js/easyui/themes/icon.css" />
	<script type="text/javascript" src="js/easyui/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="js/easyui/locale/easyui-lang-zh_CN.js"></script>
<script src="http://www.jq22.com/jquery/jquery-migrate-1.2.1.min.js"></script>
	<script language="javascript" src="js/jquery.jqprint-0.3.js"></script>
	<script>
	//房型获取
				var typelist=[];
						$.ajax({
							type : "post",
							url :"room/getrtype.do?act=gettypelist",
							async : false,
							success : function(data){   
						      $.each(data.rtlist, function(index,item){
						 		var arr= {id: item.id,typename: item.typename};
						 		typelist.push(arr);
								 });
							}
						});
		
	</script>
	</head>
	<body>
	<div id="print" style="width: 100%;height: 100%;">
	
	<table id="dg" class="easyui-datagrid"  style="height: 98%;"
			data-options="
				iconCls: 'icon-edit',
				singleSelect: true,
				toolbar: '#tb',
				url: 'room/getlist.do',
				method: 'get',
				onDblClickRow: onClickRow,
				pagination: true , 
				pageSize: 10 ,
				pageList:[5,10,15,20],
				rownumbers:true,
				striped:true,
				auto:true,
				rowStyler: function(index ,record){
								 if(record.state ==0){
									 return 'background:yellow';
									 };
								 }"
				>
				
		<thead>
			<tr>
				<th data-options="field:'roomnum',width:80">房间号</th>
				<th data-options="field:'roomtype',width:100,
						formatter:function(value,row){
							return row.roomType.typename;
						},
						editor:{
							type:'combobox',
							options:{
								data:typelist,
								valueField:'id',
								textField:'typename',
								required:true,
							}
						}">房型</th>
				<!-- <th data-options="field:'roomnum',width:80,align:'center',editor:{type:'numberbox',options:{precision:0}}">房号</th> -->
				<th data-options="field:'roompwd',width:80,align:'right',editor:'text'">房卡密码</th>
				<th data-options="field:'tel',width:80,align:'right',editor:'numberbox'">客房电话</th>
				<th data-options="field:'relprice',width:60,align:'right',editor:'numberbox',formatter:function(value,row){if(value!=null&&value!='')return '￥'+value;}">特价/元</th>
				<th data-options="field:'floor',width:50,editor:'textbox',align:'center',">楼层/层</th>
				<th data-options="field:'window',width:60,align:'center',formatter:function(value,row){if(value==1)return '有';else return '无';},
						editor:{type:'checkbox',options:{on:'1',off:'0'}}">有窗</th>
				<th data-options="field:'state',width:60,align:'center',formatter:function(value,row){if(value==1)return '正常';else return '停用';}, editor:{type:'checkbox',options:{on:'1',off:'0'}}">状态</th>
				<th data-options="field:'remark',width:423,align:'center'">备注信息</th>	
			</tr>
		</thead>
	</table>
		</div>
	
 
	<div id="tb" style="height:auto">
		<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true" onclick="append()">新增</a>
		<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true" onclick="removeit()">删除</a>
		<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-save',plain:true" onclick="accept()">保存</a>
		<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-undo',plain:true" onclick="reject()">撤销</a>
		<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-undo',plain:true" onclick="print();">打印</a>
<!-- 		<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:true" onclick="getChanges()">获得改变的列数</a> -->
	</div>
	 
	<script type="text/javascript">
		function print(){
			$('#print').jqprint({
				 debug: false,            
                importCSS: false,         
                printContainer: true,    
                operaSupport: true 
			});
		}
		var editIndex = undefined;
		function endEditing(){
			if (editIndex == undefined){return true;}
			if ($('#dg').datagrid('validateRow', editIndex)){
				var ed = $('#dg').datagrid('getEditor', {index:editIndex,field:'roomtype'});
				var roomtype = $(ed.target).combobox('getValue');
				$('#dg').datagrid('endEdit', editIndex);
				$('#dg').datagrid('refreshRow', editIndex); 
				var roominfo=$('#dg').datagrid('getSize')[editIndex];
				var window=roominfo['window'];
				var floor=roominfo['floor'];
				var tel=roominfo['tel'];
				var roomid=roominfo.id;
				var roomnum=roominfo.roomnum;
				var roompwd=roominfo.roompwd;
				var relprice=roominfo.relprice;
				var state=roominfo.state;
				 $.ajax({
									type: 'post' ,
									url: 'room/update.do' ,
									cache:false ,
									data:{id:roomid,window:window,floor:floor,tel:tel,roomtype:roomtype,roompwd:roompwd,roomnum:roomnum,relprice:relprice,state:state},
									success:function(result){
										//3 提示信息
										$.messager.show({
											title:result.status , 
											msg:result.msg,
											timeout:320
										});
									} ,
									error:function(result){
										$.meesager.show({
											title:result.status , 
											msg:result.msg,
											timeout:320
										});
									}
								});
								
				editIndex = undefined;
				return true;
			} else {
				return false;
			}
			//2刷新datagrid 
			$('#dg').datagrid('reload');
		}
		function onClickRow(index){
			if (editIndex != index){
				reject();
				if (endEditing()){
					$('#dg').datagrid('selectRow', index).datagrid('beginEdit', index);
					/*S  房型赋初值 */
					var typeid=$('#dg').datagrid('getSize')[index].roomType.id;
					var typename=$('#dg').datagrid('getSize')[index].roomType.typename;
						// 得到单元格对象,index指哪一行,field跟定义列的那个一样
						var ed = $('#dg').datagrid('getEditor', {index:index,field:'roomtype'});
						$(ed.target).combobox('setValue',typeid);
						$(ed.target).combobox('setText',typename);
					/*E  房型赋初值*/							
							
					editIndex = index;
				} else {
					$('#dg').datagrid('selectRow', editIndex);
				}
			}
		}
		function append(){
			$('#mydialog').dialog('open');
		}
		function removeit(){
			if (editIndex == undefined){return;}
			$.messager.confirm('确认操作', '确定删除此房间？', function(r){
					if (r){
						var roomid=$('#dg').datagrid('getSize')[editIndex].id;
							$.post("room/delete.do",{roomid:roomid},function(result){
									   		 $.messager.show({
												title:result.status , 
												msg:result.msg,
												timeout:320
											});
									  });
							$('#dg').datagrid('cancelEdit', editIndex).datagrid('deleteRow', editIndex);
							editIndex = undefined;		
						}
					else 
						reject();
				});
		}
		function accept(){
			if (endEditing()){
				$('#dg').datagrid('acceptChanges');
			}
		}
		function reject(){
			$('#dg').datagrid('rejectChanges');
			editIndex = undefined;
		}
		/*function getChanges(){
			var size = $('#dg').datagrid('getChanges');
			alert(size.length+' size are changed!');
		}
		*/
	</script>
	<!-- start dialog adduser-->
		<div id="mydialog" title="新增房间" modal="true" draggable="false"
			class="easyui-dialog" closed="true" style="width: 300px;">
			<form id="myform" action="" method="post">
				<input type="hidden" name="id" value="" />
				<table>
					<tr>
						<td>
							房间号:
						</td>
						<td>
							<input type="text" name="roomnum" value="" class="easyui-validatebox" required=true validType="midLength[2,5]" missingMessage="房间号必填!"
								invalidMessage="房间号必须在2到5个字符之间!" value="" />
						</td>
					</tr>
					<tr>
						<td>
							客房电话:
						</td>
						<td>
							<input type="text" name="tel" class="easyui-validatebox"
								required=true validType="midLength[2,5]" missingMessage="客房电话必填!"
								invalidMessage="客房电话必须在2到5个字符之间!" value="" />
						</td>
					</tr>
					<tr>
						<td>
							房卡密码:
						</td>
						<td>
							<input type="password" name="roompwd" class="easyui-validatebox"
								required=true validType="equalLength[4]" missingMessage="密码必填!"
								value="" />
						</td>
					</tr>
					<tr>
						<td>
							房间类型:
						</td>
						<td>
							<input class="easyui-combobox" data-options="valueField: 'id',textField: 'typename',data: typelist" style="150px;" name="typeid"/>
						</td>
					</tr>
					<tr>
						<td>
							状态:
						</td>
						<td>
							<select id="state" class="easyui-combobox" name="state" style="width:100px;">
							    <option value="1" selected="selected">正常</option>
							    <option value="0">停用</option>
							</select>
						</td>
					</tr>
					<tr>
						<td>
							窗户:
						</td>
						<td>
							有窗
							<input type="radio" checked="checked" name="window" value="1" />
							无窗
							<input type="radio" name="window" value="0" />
						</td>
					</tr>
					<tr>
						<td>
							楼层:
						</td>
						<td>
							<select id="floor" class="easyui-combobox" name="floor" style="width:100px;">
							    <option value="1" selected="selected">第一层</option>
							    <option value="2">第二层</option>
							    <option value="3">第三层</option>
							</select>
						</td>
					</tr>
					<tr>
						<td>
							特价房:
						</td>
						<td>
							<input id="relprice" style="width: 160px;" type="text"
								name="relprice" value="" />元
						</td>
					</tr>
					<tr>
						<td>
							其他信息:
						</td>
						<td>
							<input type="text" name="remark" class="easyui-validatebox"
								 validType="midLength[0,50]"
								invalidMessage="备注不得超过50个字符!"
								value="" />
						</td>
					</tr>
					<tr align="center">
						<td colspan="2">
							<a id="btn1" class="easyui-linkbutton">确定</a>
							<a id="btn2" class="easyui-linkbutton">关闭</a>
						</td>
					</tr>
				</table>
			</form>
		</div>
				<script type="text/javascript">
		$(function(){
			$('#btn1').click(function(){
							if($('#myform').form('validate')){
								$.ajax({
									type: 'post' ,
									url: 'room/save.do' ,
									cache:false ,
									data:$('#myform').serialize(),	
									dataType:'json' ,
									success:function(result){
										//1 关闭窗口
										$('#mydialog').dialog('close');
										//2刷新datagrid 
										$('#dg').datagrid('reload');
										//3 提示信息
										$.messager.show({
											title:result.status , 
											msg:result.message,
											timeout:320
											
										});
									} ,
									error:function(result){
										$.meesager.show({
											title:result.status , 
											msg:result.message,
											timeout:320
											
										});
									}
								});
							} else {
								$.messager.show({
									title:'提示信息!' ,
									msg:'数据验证不通过,不能保存!',
									timeout:320
								});
							}
					});
					});
					</script>
		<!-- end dialog adduser-->
</body>
</html>
