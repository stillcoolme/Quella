<div class="layui-tab layui-tab-brief" lay-filter="docDemoTabBrief">
    <ul class="layui-tab-title">
        <li class="layui-this">七牛云存储</li>
        <li>存储测试</li>
        <li>使用说明</li>
    </ul>
    <div class="layui-tab-content" style="height: 100px;">
        <div class="layui-tab-item layui-show">
            <form class="layui-form layui-form-pane" action="">
                <div class="layui-form-item">
                    <label class="layui-form-label">KeyId</label>
                    <div class="layui-input-block">
                        <input name="fqAccesskey" lay-verify="required" value="${(fileQiniu.fqAccesskey)!}" placeholder="请输入你在七牛云存储后台的AccessKeyId" autocomplete="off" class="layui-input" type="text">
                    </div>
                </div>

                <div class="layui-form-item">
                    <label class="layui-form-label">KeySecret</label>
                    <div class="layui-input-block">
                        <input name="fqSecretkey" lay-verify="required" value="${(fileQiniu.fqSecretkey)!}" placeholder="请输入你在七牛云存储KeySecret" autocomplete="off" class="layui-input" type="password">
                    </div>
                </div>

                <div class="layui-form-item">
                    <label class="layui-form-label">Buncket</label>
                    <div class="layui-input-block">
                        <input name="fqBucket" lay-verify="required" value="${(fileQiniu.fqBucket)!}" placeholder="请输入你在七牛云存储的buncket" autocomplete="off" class="layui-input" type="text">
                    </div>
                </div>

                <div class="layui-form-item">
                    <label class="layui-form-label">URL</label>
                    <div class="layui-input-block">
                        <input name="fqUrl" lay-verify="required" value="${(fileQiniu.fqUrl)!}" placeholder="请输入你在七牛云存储的域名" autocomplete="off" class="layui-input" type="text">
                    </div>
                </div>

                <div class="layui-form-item">
                    <label class="layui-form-label">zone</label>
                    <div class="layui-input-block">
                        <input name="fqZone"  lay-verify="required" value="${(fileQiniu.fqZone)!}" placeholder="机房信息" autocomplete="off" class="layui-input" type="text">
                    </div>
                </div>

                <div class="layui-form-item">
                    <button class="layui-btn" lay-submit="required" lay-filter="fileQiniuupdate">提交</button>
                </div>
            </form>

        </div>

        <div class="layui-tab-item">
            <fieldset class="layui-elem-field layui-field-title" style="margin-top: 30px;">
                <legend>常规使用：普通图片上传</legend>
            </fieldset>
            <div class="layui-upload">
            <button type="button" class="layui-btn" id="test1">上传图片</button>
            <div class="layui-upload-list">
                <img class="layui-upload-img" id="demo1">
                <p id="demoText"></p>
            </div>
        </div>
        </div>

        <div class="layui-tab-item">

            <fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
                <legend>使用说明</legend>
            </fieldset>
            <blockquote class="layui-elem-quote"></blockquote>
            <pre class="layui-code">
            </pre>

            <blockquote class="layui-elem-quote"></blockquote>
            <pre class="layui-code">
            </pre>
        </div>
    </div>
</div>
    <script src="${basePath}/js/jquery.js"></script>
    <script src="${basePath}/plugins/kit-admin/layui.js"></script>
    <script>
        layui.use(['form', 'layedit', 'element', 'layer','upload'], function(){
            var form = layui.form, layer = layui.layer,upload = layui.upload;

            //普通图片上传
            var uploadInst = upload.render({
                elem: '#test1'
                ,url: '${basePath}/fileQiniu/fileQiniuUploadTest'
                ,before: function(obj){
                    //预读本地文件示例，不支持ie8
                    obj.preview(function(index, file, result){
                        $('#demo1').attr('src', result); //图片链接（base64）
                    });
                }
                ,done: function(res){
                    //如果上传失败
                    if(res.status != 200){
                        return layer.msg('上传失败');
                    }
                    //上传成功
                    var demoText = $('#demoText');
                    demoText.html('<span style="color: #2ec01f;">上传成功,图片地址：<a href="'+res.src+'" target="_blank">'+res.src+'</a> </span> <a class="layui-btn layui-btn-xs demo-reload">重试</a>');
                    demoText.find('.demo-reload').on('click', function(){
                        uploadInst.upload();
                    });
                }
                ,error: function(){
                    //演示失败状态，并实现重传
                    var demoText = $('#demoText');
                    demoText.html('<span style="color: #FF5722;">上传失败</span> <a class="layui-btn layui-btn-xs demo-reload">重试</a>');
                    demoText.find('.demo-reload').on('click', function(){
                        uploadInst.upload();
                    });
                }
            });

            //监听提交，发送请求
            form.on('submit(fileQiniuupdate)', function(data){

                $.post("${basePath}/fileQiniu/update",data.field,function(d){

                    // 获取 session
                    if(d.status!=200){
                        layer.alert(d.message, {offset: 't',icon: 5});
                    }
                    if(d.status==200){
                        layer.alert(d.message, {offset: 't',icon: 6});
                    }
                });
                return false;
            });


        });
    </script>