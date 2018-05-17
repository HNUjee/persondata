layui.config({
	base : "assets/js/"
}).use(['form','layer','jquery'],function(){
	var form = layui.form(),
		layer = parent.layer === undefined ? layui.layer : parent.layer,
		$ = layui.jquery;
	//自定义验证
 	form.verify({
 		typeName: function(value){ //value：表单的值、
 		    if(value.length > 15){
 		      return '不能超过1o5字符';
 		    }
 		  }
 		});      
 	form.on("submit(addNews)",function(data){
 		var str={"typeId":$(".id").val(),
 				"typeName":$(".type").val(),
			}
 		 $.ajax({
 			url : 'articletypesave',
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
			top.layer.msg("添加成功！");
 			layer.closeAll("iframe");
	 		//刷新当前页面
 			parent.location.reload();
        },2000);
 		return false;
 	})
	
})
