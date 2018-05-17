<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>图片添加</title>
	<meta name="renderer" content="webkit">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
	<meta name="apple-mobile-web-app-status-bar-style" content="black">
	<meta name="apple-mobile-web-app-capable" content="yes">
	<meta name="format-detection" content="telephone=no">
	<meta http-equiv="Content-Type" content="multipart/form-data; charset=utf-8" />
	<link rel="stylesheet" href="${ctx }/assets/layui/css/layui.css" media="all" />
</head>
<body class="childrenBody">
<form class="layui-form" action="" method="post" enctype="multipart/form-data">
	<fieldset class="layui-elem-field layui-field-title" style="margin-top: 30px;">
		<legend>图片上传</legend>
	</fieldset> 
<div class="layui-upload">
  <button type="button" class="layui-btn layui-btn-normal" id="pictureList">选择多文件</button> 
  	<div class="layui-inline">
    <label class="layui-form-label">相册分类</label>
    <div class="layui-input-block">
      <select class="sid"  lay-filter="id" aria-invalid="false">
	      <c:forEach var="category" items="${categorys }" varStatus="status">
				 <option value="${category.id}">${category.name}</option>
		</c:forEach> 
      </select>
 	</div>
  	</div>
  <div class="layui-upload-list">
    <table class="layui-table">
      <thead>
        <tr><th>文件名</th>
        <th>图片</th>
        <th>大小</th>
        <th>状态</th>
        <th>操作</th>
      </tr></thead>
      <tbody id="imageList"></tbody>
    </table>
  </div>
  <button type="button" class="layui-btn" id="ListAction" class="action">开始上传</button>
</div> 
</form>
	<script type="text/javascript" src="${ctx }/assets/layui-v2.2.5/layui/layui.js"></script>
	<script type="text/javascript">
	layui.use(['upload','form','jquery'], function(){
		  var $ = layui.jquery,
		  form=layui.form,
		  upload = layui.upload,
		  $=layui.jquery;
		  form.render();
			//多文件列表示例
			var g_rootPath = "${ctx}";
			  var ListView = $('#imageList')
			  ,uploadListIns = upload.render({
			    elem: '#pictureList'
			    ,url: g_rootPath+"/uploadfile"
			    ,accept: 'file'
			    ,multiple: true
			    ,auto: false
			    ,bindAction: '#ListAction'
			    ,data:{id:$(".sid").val()}
			    ,choose: function(obj){   
			      var files = this.files = obj.pushFile(); //将每次选择的文件追加到文件队列
			      //读取本地文件
			      obj.preview(function(index, file, result){
			        var tr = $(['<tr id="upload-'+ index +'">'
			          ,'<td>'+ file.name +'</td>'
			          ,'<td>'+'未上传'+'</td>'
			          ,'<td>'+ (file.size/1014).toFixed(1) +'kb</td>'
			          ,'<td>等待上传</td>'
			          ,'<td>'
			            ,'<button class="layui-btn layui-btn-mini reload layui-hide">重传</button>'
			            ,'<button class="layui-btn layui-btn-mini layui-btn-danger delete">删除</button>'
			          ,'</td>'
			        ,'</tr>'].join(''));
			        //单个重传
			        tr.find('.reload').on('click', function(){
			          obj.upload(index, file);
			        });
			        
			        //删除
			        tr.find('.delete').on('click', function(){
			          delete files[index]; //删除对应的文件
			          tr.remove();
			          uploadListIns.config.elem.next()[0].value = ''; //清空 input file 值，以免删除后出现同名文件不可选
			        });
			        
			        ListView.append(tr);
			      });
			    }
			    ,done: function(res, index, upload){
			    	var src=res.data.src;
			      if(res.code == 0){ //上传成功
			        var tr = ListView.find('tr#upload-'+ index)
			        ,tds = tr.children();
			        tds.eq(3).html('<span style="color: #5FB878;">上传成功</span>');
			        tds.eq(1).html('<img src='+g_rootPath/src+'>');
			        tds.eq(4).html(''); //清空操作
			        return delete this.files[index]; //删除文件队列已经上传成功的文件
			      }
			      this.error(index, upload);
			    }
			    ,error: function(index, upload){
			      var tr = ListView.find('tr#upload-'+ index)
			      ,tds = tr.children();
			      tds.eq(3).html('<span style="color: #FF5722;">上传失败</span>');
			      tds.eq(4).find('.reload').removeClass('layui-hide'); //显示重传
			    }
			  });
			
			  /*数据新增方法*/
			    function save() {
			        var fd = new FormData();
			        var formData = new FormData($( "form" )[0]);
			        $.ajax({
			            cache : true,
			            type : "post",
			            url : g_rootPath+"/picture/upload",
			            /* data : $('#signupForm').serialize(), */ // 你的formid
			            data : formData,  // 你的formid
			            async : false,
			            contentType: false,   //jax 中 contentType 设置为 false 是为了避免 JQuery 对其操作，从而失去分界符，而使服务器不能正常解析文件
			            processData: false,   //当设置为true的时候,jquery ajax 提交的时候不会序列化 data，而是直接使用data
			            error : function(request) {
			                parent.layer.alert("网络超时");
			            },
			            success : function(data) {
			                if (data.code == 0) {
			                    parent.layer.msg("操作成功");
			                    parent.reLoad();
			                    //注意这两句
			                    var index = parent.layer.getFrameIndex(window.name);///先得到当前iframe层的索引
			                    parent.layer.close(index);//再执行关闭，保存、修改页面完成时要获取当前页面并关闭回到上级页面（list页面）起到刷新返回功能
			                } else {
			                    parent.layer.alert(data.msg)
			                }
			            }
			        });
			    }
		})
	</script>
</body>
</html>