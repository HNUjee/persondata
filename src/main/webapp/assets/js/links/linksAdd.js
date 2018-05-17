layui.config({
	base : "assets/js/"
}).use(['form','layer','jquery'],function(){
	var form = layui.form(),
		layer = parent.layer === undefined ? layui.layer : parent.layer,
		$ = layui.jquery;
 	var addLinksArray = [],addLinks;
 	form.on("submit(addLinks)",function(data){
 		var str={"id":$(".id").val(),
 				"linkName":$(".linksName").val(),
 				"linksUrl":$(".linksUrl").val(),
 				"createTime":new Date().getTime(),
 				"linksDesc":$(".linksDesc").val(),
			}
 		 $.ajax({
 			url : 'linksave',
 			data : JSON.stringify(str),
 			type:'POST',//默认以get提交，以get提交如果是中文后台会出现乱码
 			contentType:'application/json;charset=utf-8',
 			dataType : 'json',
 			success : function(obj) {
 				
 			}
 		});
 		//弹出loading
 		var index = top.layer.msg('数据提交中，请稍候',{icon: 16,time:false,shade:0.8});
        setTimeout(function(){
            top.layer.close(index);
			top.layer.msg("添加成功！");
 			layer.closeAll("iframe");
	 		//刷新父页面
	 		parent.location.reload();
        },2000);
 		return false;
 	})
	
})
