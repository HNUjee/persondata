layui.config({
	base : "assets/js/"
}).use(['form','layer','jquery','layedit','upload','laydate'],function(){
	var form = layui.form(),
		layer = parent.layer === undefined ? layui.layer : parent.layer,
		laypage = layui.laypage,
		layedit = layui.layedit,
		laydate = layui.laydate,
		upload = layui.upload,
		$ = layui.jquery;
		//上传图片,必须放在 创建一个编辑器前面
		 layedit.set({
	          uploadImage: {
	               url: 'uploadFile',//接口
	               type: 'post' //默认post
	          }
	      });
	//创建一个编辑器
 	var editIndex = layedit.build('news_content');
 	form.verify({
 		author: function(value){ //value：表单的值、
 		    if(value.length > 15){
 		      return '不能超过5字符';
 		    }
 		  }
 		});      
 	form.on("submit(addNews)",function(data){
 		var str={"id":$(".id").val(),
 				"title":$(".title").val(),
 				"author":$(".author").val(),
 				"createTime":new Date().getTime(),
 				"look":$(".look").val(),
 				"type":$(".type").val(),
 				"keywords":$(".keywords").val(),
 				"content":UE.getEditor('editor').getContent(),
 				//"content":layedit.getContent(editIndex),
			}
 		 $.ajax({
 			url : 'articlesave',
 			data : JSON.stringify(str),
 			type:'POST',//默认以get提交，以get提交如果是中文后台会出现乱码
 			contentType:'application/json;charset=utf-8',
 			dataType : 'json',
 			success : function(obj) {
 				
 			}
 		});
 		var index = top.layer.msg('数据提交中，请稍候',{icon: 16,time:false,shade:0.8});
        setTimeout(function(){
            top.layer.close(index);
			top.layer.msg("文章添加成功！");
 			layer.closeAll("iframe");
	 		//刷新当前页面
 			parent.location.reload();
 			
        },2000);
 		return false;
 	})
	
})
