 	 $(".childrenBody").find("form").on("submit", function(e) {
			// 阻止表单默认提交事件
			e.preventDefault();

			var $this = $(this);

			// jquery-form的异步提交方式
			$this.ajaxSubmit({
				beforeSubmit : function(data, $form) {
					var name = $form.find("input[name='name']");

					if ($.trim(name.val()) === "") {
						return false;
					} else {
						
					}
				},
				success : function() {
					parent.location.reload();
				}
			});
		});
 
 	// 保存用户
 	 $(".childrenBody").find(".addNews").on("click", function() {
 		$(".childrenBody").find("form").trigger("submit");
	});
 		//console.log(str.category);
// 		 $.ajax({
// 			url : 'contactSave',
// 			data : JSON.stringify(str),
// 			type:'POST',//默认以get提交，以get提交如果是中文后台会出现乱码
// 			contentType:'application/json;charset=utf-8',
// 			dataType : 'json',
// 			success : function(obj) {
// 				
// 			}
// 		});
        setTimeout(function(){
 			parent.location.reload();
 			
        },1000);
 	//});
 	$("#test").change(function(){  
 		  // getObjectURL是自定义的函数，见下面  
 		  // this.files[0]代表的是选择的文件资源的第一个，因为上面写了 multiple="multiple" 就表示上传文件可能不止一个  
 		  // ，但是这里只读取第一个   
 		  var objUrl = getObjectURL(this.files[0]) ;  
 		  if (objUrl) {  
 		    // 在这里修改图片的地址属性  
 		    $("#upload").attr("src", objUrl) ;  
 		  }  
 		}) ;  
 		//建立一個可存取到該file的url  
 		function getObjectURL(file) {  
 		  var url = null ;   
 		  // 下面函数执行的效果是一样的，只是需要针对不同的浏览器执行不同的 js 函数而已  
 		  if (window.createObjectURL!=undefined) { // basic  
 		    url = window.createObjectURL(file) ;  
 		  } else if (window.URL!=undefined) { // mozilla(firefox)  
 		    url = window.URL.createObjectURL(file) ;  
 		  } else if (window.webkitURL!=undefined) { // webkit or chrome  
 		    url = window.webkitURL.createObjectURL(file) ;  
 		  }  
 		  return url;  
 		}  
	
