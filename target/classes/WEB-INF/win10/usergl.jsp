<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html>
<head>
    <base href="<%=basePath%>">
    <meta charset="utf-8">
    <title>用户管理</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <link rel="stylesheet" href="./component/layer-v3.0.3/layer/layui.css" >
    <link rel="stylesheet" href="./component/layer-v3.0.3/layer/skin/default/layer.css" >
</head>
<body>
<div class="toolDiv">
<div class="layui-inline">
    工号：<input class="layui-input" name="usernum" id="usernum" autocomplete="off">
    用户名：<input class="layui-input" name="username" id="username" autocomplete="off">
    角色：<input class="layui-input" name="role" id="role" autocomplete="off">
    <shiro:hasPermission name="user:add"><button class="layui-btn" lay-event="add">添加</button></shiro:hasPermission>
</div>
<button class="layui-btn" data-type="reload">搜索</button>
</div>

<script type="template" id="userform">
    <%--用户信息form start--%>
    <div>
        <form class="layui-form" action="">
            <div class="layui-form-item">
                <label class="layui-form-label">单行输入框</label>
                <div class="layui-input-block">
                    <input type="text" name="title" lay-verify="title" autocomplete="off" placeholder="请输入标题" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">验证必填项</label>
                <div class="layui-input-block">
                    <input type="text" name="username" lay-verify="required" placeholder="请输入" autocomplete="off" class="layui-input">
                </div>
            </div>

            <div class="layui-form-item">
                <div class="layui-inline">
                    <label class="layui-form-label">验证手机</label>
                    <div class="layui-input-inline">
                        <input type="tel" name="phone" lay-verify="required|phone" autocomplete="off" class="layui-input">
                    </div>
                </div>
                <div class="layui-inline">
                    <label class="layui-form-label">验证邮箱</label>
                    <div class="layui-input-inline">
                        <input type="text" name="email" lay-verify="email" autocomplete="off" class="layui-input">
                    </div>
                </div>
            </div>

            <div class="layui-form-item">
                <div class="layui-inline">
                    <label class="layui-form-label">多规则验证</label>
                    <div class="layui-input-inline">
                        <input type="text" name="number" lay-verify="required|number" autocomplete="off" class="layui-input">
                    </div>
                </div>
                <div class="layui-inline">
                    <label class="layui-form-label">验证日期</label>
                    <div class="layui-input-inline">
                        <input type="text" name="date" id="date" lay-verify="date" placeholder="yyyy-MM-dd" autocomplete="off" class="layui-input">
                    </div>
                </div>
                <div class="layui-inline">
                    <label class="layui-form-label">验证链接</label>
                    <div class="layui-input-inline">
                        <input type="tel" name="url" lay-verify="url" autocomplete="off" class="layui-input">
                    </div>
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label">验证身份证</label>
                <div class="layui-input-block">
                    <input type="text" name="identity" lay-verify="identity" placeholder="" autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">自定义验证</label>
                <div class="layui-input-inline">
                    <input type="password" name="password" lay-verify="pass" placeholder="请输入密码" autocomplete="off" class="layui-input">
                </div>
                <div class="layui-form-mid layui-word-aux">请填写6到12位密码</div>
            </div>

            <div class="layui-form-item">
                <div class="layui-inline">
                    <label class="layui-form-label">范围</label>
                    <div class="layui-input-inline" style="width: 100px;">
                        <input type="text" name="price_min" placeholder="￥" autocomplete="off" class="layui-input">
                    </div>
                    <div class="layui-form-mid">-</div>
                    <div class="layui-input-inline" style="width: 100px;">
                        <input type="text" name="price_max" placeholder="￥" autocomplete="off" class="layui-input">
                    </div>
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label">单行选择框</label>
                <div class="layui-input-block">
                    <select name="interest" lay-filter="aihao">
                        <option value=""></option>
                        <option value="0">写作</option>
                        <option value="1" selected="">阅读</option>
                        <option value="2">游戏</option>
                        <option value="3">音乐</option>
                        <option value="4">旅行</option>
                    </select>
                </div>
            </div>


            <div class="layui-form-item">
                <div class="layui-inline">
                    <label class="layui-form-label">分组选择框</label>
                    <div class="layui-input-inline">
                        <select name="quiz">
                            <option value="">请选择问题</option>
                            <optgroup label="城市记忆">
                                <option value="你工作的第一个城市">你工作的第一个城市</option>
                            </optgroup>
                            <optgroup label="学生时代">
                                <option value="你的工号">你的工号</option>
                                <option value="你最喜欢的老师">你最喜欢的老师</option>
                            </optgroup>
                        </select>
                    </div>
                </div>
                <div class="layui-inline">
                    <label class="layui-form-label">搜索选择框</label>
                    <div class="layui-input-inline">
                        <select name="modules" lay-verify="required" lay-search="">
                            <option value="">直接选择或搜索选择</option>
                            <option value="1">layer</option>
                            <option value="2">form</option>
                            <option value="3">layim</option>
                            <option value="4">element</option>
                            <option value="5">laytpl</option>
                            <option value="6">upload</option>
                            <option value="7">laydate</option>
                            <option value="8">laypage</option>
                            <option value="9">flow</option>
                            <option value="10">util</option>
                            <option value="11">code</option>
                            <option value="12">tree</option>
                            <option value="13">layedit</option>
                            <option value="14">nav</option>
                            <option value="15">tab</option>
                            <option value="16">table</option>
                            <option value="17">select</option>
                            <option value="18">checkbox</option>
                            <option value="19">switch</option>
                            <option value="20">radio</option>
                        </select>
                    </div>
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label">联动选择框</label>
                <div class="layui-input-inline">
                    <select name="quiz1">
                        <option value="">请选择省</option>
                        <option value="浙江" selected="">浙江省</option>
                        <option value="你的工号">江西省</option>
                        <option value="你最喜欢的老师">福建省</option>
                    </select>
                </div>
                <div class="layui-input-inline">
                    <select name="quiz2">
                        <option value="">请选择市</option>
                        <option value="杭州">杭州</option>
                        <option value="宁波" disabled="">宁波</option>
                        <option value="温州">温州</option>
                        <option value="温州">台州</option>
                        <option value="温州">绍兴</option>
                    </select>
                </div>
                <div class="layui-input-inline">
                    <select name="quiz3">
                        <option value="">请选择县/区</option>
                        <option value="西湖区">西湖区</option>
                        <option value="余杭区">余杭区</option>
                        <option value="拱墅区">临安市</option>
                    </select>
                </div>
                <div class="layui-form-mid layui-word-aux">此处只是演示联动排版，并未做联动交互</div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label">复选框</label>
                <div class="layui-input-block">
                    <input type="checkbox" name="like[write]" title="写作">
                    <input type="checkbox" name="like[read]" title="阅读" checked="">
                    <input type="checkbox" name="like[game]" title="游戏">
                </div>
            </div>

            <div class="layui-form-item" pane="">
                <label class="layui-form-label">原始复选框</label>
                <div class="layui-input-block">
                    <input type="checkbox" name="like1[write]" lay-skin="primary" title="写作" checked="">
                    <input type="checkbox" name="like1[read]" lay-skin="primary" title="阅读">
                    <input type="checkbox" name="like1[game]" lay-skin="primary" title="游戏" disabled="">
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label">开关-默认关</label>
                <div class="layui-input-block">
                    <input type="checkbox" name="close" lay-skin="switch" lay-text="ON|OFF">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">开关-默认开</label>
                <div class="layui-input-block">
                    <input type="checkbox" checked="" name="open" lay-skin="switch" lay-filter="switchTest" lay-text="ON|OFF">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">单选框</label>
                <div class="layui-input-block">
                    <input type="radio" name="sex" value="男" title="男" checked="">
                    <input type="radio" name="sex" value="女" title="女">
                    <input type="radio" name="sex" value="禁" title="禁用" disabled="">
                </div>
            </div>
            <div class="layui-form-item layui-form-text">
                <label class="layui-form-label">普通文本域</label>
                <div class="layui-input-block">
                    <textarea placeholder="请输入内容" class="layui-textarea"></textarea>
                </div>
            </div>
            <!--<div class="layui-form-item layui-form-text">
              <label class="layui-form-label">编辑器</label>
              <div class="layui-input-block">
                <textarea class="layui-textarea layui-hide" name="content" lay-verify="content" id="LAY_demo_editor"></textarea>
              </div>
            </div>-->
            <div class="layui-form-item">
                <div class="layui-input-block">
                    <button class="layui-btn" lay-submit="" lay-filter="demo1">立即提交</button>
                    <button type="reset" class="layui-btn layui-btn-primary">重置</button>
                </div>
            </div>
        </form>
    </div>
    <%--用户信息form end--%>

</script>
<table class="layui-hide" id="userTable" lay-filter="user"></table>
<script type="text/html" id="barDemo">
    <shiro:hasPermission name="user:view"><a class="layui-btn layui-btn-normal layui-btn-xs" lay-event="detail">查看</a></shiro:hasPermission>
    <shiro:hasPermission name="user:update"><a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a></shiro:hasPermission>
    <shiro:hasPermission name="user:del"><a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a></shiro:hasPermission>
</script>
<%--性别Tpl--%>
<script type="text/html" id="sexTpl">
    {{#  if(d.sex === '2'){ }}
    <span style="color: #F581B1;">{{ "女" }}</span>
    {{#  } else { }}
    {{ "男" }}
    {{#  } }}
</script>
<%--用户状态Tpl--%>
<script type="text/html" id="checkboxTpl">
    <input type="checkbox" name="lock" value="{{d.id}}" title="锁定" lay-filter="lockDemo" {{ d.state =='0' ? 'checked' : '' }} >
</script>
<script type="text/javascript" src="./component/layer-v3.0.3/layer/layui.js"></script>
<script>
    layui.use('table', function(){
        var table = layui.table;
        //监听表格复选框选择
        table.on('checkbox(user)', function(obj){
            console.log(obj)
        });
        //监听工具条
        table.on('tool(user)', function(obj){
            var data = obj.data;
            if(obj.event === 'detail'){
                layer.msg('ID：'+ data.id + ' 的查看操作');
                layer.open({
                    type: 1,
                    content: $('#infoform') //这里content是一个DOM，注意：最好该元素要存放在body最外层，否则可能被其它的相对元素所影响
                });
            } else if(obj.event === 'del'){
                layer.confirm('真的删除行么', function(index){
                    obj.del();
                    layer.close(index);
                });
            } else if(obj.event === 'edit'){
                layer.alert('编辑行：<br>'+ JSON.stringify(data))
            }
            else if (obj.event=='add'){

            }
        });


        //方法级渲染
        table.render({
            elem: '#userTable'
            ,url: 'user/getlist.do'
            ,cols: [[
                {checkbox: true}
                ,{field:'usernum', title: '工号', width:80, sort: true}
                ,{field:'username', title: '用户名', width:80, sort: true}
                ,{field:'sex', title: '性别', width:65, sort: true,  templet: '#sexTpl'}
                ,{field:'age', title: '年龄', width:65, sort: true}
                ,{field:'birthday', title: '生日', width:110, sort: true}
                ,{field:'salary', title: '薪水', width:90, sort: true}
                ,{field:'tel', title: '电话', width:120}
                ,{field:'email', title: '邮箱', width:150}
                ,{field:'description', title: '描述', width:120}
                ,{field:'state', title: '状态',width:110, templet: '#checkboxTpl', unresize: true}
                ,{field:'right',title:'操作',toolbar:'#barDemo'}
            ]]
            ,id: 'userReload'
            ,page: true
            ,height: 315
            ,even :true
            ,
        });

        var $ = layui.$, active = {
            reload: function(){
                var usernum = $('#usernum');
                //执行重载
                table.reload('userReload', {
                    page: {
                        curr: 1 //重新从第 1 页开始
                    }
                    ,where: {
                            usernum: usernum.val()
                    }
                });
            }
        };
        $('.toolDiv .layui-btn').on('click', function(){
            var type = $(this).data('type');
            active[type] ? active[type].call(this) : '';
        });
        // var $ = layui.$, active = {
        //     getCheckData: function(){ //获取选中数据
        //         var checkStatus = table.checkStatus('idTest')
        //             ,data = checkStatus.data;
        //         layer.alert(JSON.stringify(data));
        //     }
        //     ,getCheckLength: function(){ //获取选中数目
        //         var checkStatus = table.checkStatus('idTest')
        //             ,data = checkStatus.data;
        //         layer.msg('选中了：'+ data.length + ' 个');
        //     }
        //     ,isAll: function(){ //验证是否全选
        //         var checkStatus = table.checkStatus('idTest');
        //         layer.msg(checkStatus.isAll ? '全选': '未全选')
        //     }
        // };

    });
</script>
</body>
</html>