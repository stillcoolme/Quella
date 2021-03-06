
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>权限编辑</title>
    <link rel="stylesheet" href="${basePath}/plugins/kitadmin/css/theme/default.css" id="theme">
    <link rel="stylesheet" href="${basePath}/plugins/kitadmin/css/kitadmin.css" id="kitadmin">
    <link rel="stylesheet" href="${basePath}/css/doc.css">
    <link rel="stylesheet" href="${basePath}/plugins/kitadmin/css/layui.css" id="layui">
</head>
<body>

<div class="kit-doc">
    <form class="layui-form layui-form-pane" action="">
        <input name="id" value="${permission.id}" hidden="hidden"/>
        <div class="layui-form-item">
            <label class="layui-form-label">权限名称</label>
            <div class="layui-input-block">
                <input name="name" value="${permission.name}" lay-verify="required" placeholder="请输入角色名称" autocomplete="off" class="layui-input" type="text">
            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label">角色类型</label>
            <div class="layui-input-block">
                <input name="url" value="${permission.url}" lay-verify="required" placeholder="请输入角色类型" autocomplete="off" class="layui-input" type="text">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">上级类目</label>
            <div class="layui-input-block">
                <select name="parentId" lay-verify="required">
                    <#list permissions as p>
                        <option value="${p.id}" <#if p.id == permission.parentId>selected</#if>> ${p.name}</option>
                    </#list>
                </select>
            </div>
        </div>
        <div class="layui-form-item">
            <button class="layui-btn" lay-submit lay-filter="update">提交</button>
        </div>

    </form>

    <!--这里写页面的代码-->
</div>

<script src="${basePath}/js/jquery.js"></script>
<script src="${basePath}/plugins/layui-treeselect/plugins/layui/layui.js"></script>

<script>
    layui.use(['form', 'layedit','table'], function(){
        var form = layui.form ,layer = layui.layer;
        var table = layui.table;
        //监听提交，发送请求
        form.on('submit(update)', function(data){
            $.post("${basePath}/permission/update",data.field,function(data){
                // 获取 session
                if(data.status!=200){
                    layer.alert(data.message, {offset: 't',icon: 2});
                }
                if(data.status==200){
                    layer.alert(data.message, {offset: 't',icon: 1},function (index) {
                        layer.close(index);
                        var index2 = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
                        parent.layer.close(index2);
                    });

                }
            });
            return false;
        });
    });
</script>

</body>
</html>
