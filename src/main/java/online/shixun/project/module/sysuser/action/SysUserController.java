package online.shixun.project.module.sysuser.action;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import online.shixun.project.dto.SysuserDTO;
import online.shixun.project.module.sysuser.service.SysuserService;

@Controller
@RequestMapping("/sysuser")
public class SysUserController {
    protected Logger logger = LoggerFactory.getLogger(getClass());
    @Autowired
    private SysuserService sysuserService;

    @RequestMapping("/sysuserinfo")
    public String sysInfo(@RequestParam(defaultValue = "1") int id, Model model) {
	logger.info("根据id获取管理员信息");
	model.addAttribute("sys", sysuserService.getSysUserById(id));
	return "/user/userInfo";
    }

    @RequestMapping("/sysuserchangePwd")
    public String sysChangePwd(@RequestParam(defaultValue = "1") int id, Model model) {
	model.addAttribute("pwd", sysuserService.getSysUserById(id));
	return "/user/changePwd";
    }

    @RequestMapping("/updatePwd")
    @ResponseBody
    public String changePwd(@RequestBody SysuserDTO sysuser, HttpServletRequest request, Model model) {
	sysuserService.updatePwd(sysuser.getPassword());
	return "success";
    }

    @RequestMapping("/save")
    @ResponseBody
    public String saveOrUpdate(@RequestBody SysuserDTO sysuser, @RequestParam(required = false) MultipartFile file) {
	logger.info("保存管理员");
	sysuserService.save(sysuser);
	return "success";
    }

    @RequestMapping("/getSysuser")
    @ResponseBody
    public List<SysuserDTO> getSysuser(@RequestBody SysuserDTO sysuser) {
	logger.info("获取管理员");
	return sysuserService.getSysusers();
    }

    @RequestMapping("/uploadFace")
    @ResponseBody
    public Map<String, Object> uploadFace(@RequestParam(required = false) MultipartFile file,
	    HttpServletRequest request) {
	Map<String, Object> map = new HashMap<String, Object>();
	// 获取图片的原名字
	String oldName = file.getOriginalFilename();
	// 截取图片的类型
	String fileType = oldName.substring(oldName.lastIndexOf("."));
	// 获取当前时间作为新的图片名字 并加上后缀
	String timeName = UUID.randomUUID().toString().replaceAll("-", "");
	String newName = timeName + fileType;
	// 获取项目的路径 在项目路径下新建文件夹
	String path = request.getSession().getServletContext().getRealPath("/upload/face");
	// 新建 upload 文件夹 不存在就新建
	File parentPath = new File(path);
	if (!parentPath.exists()) {
	    parentPath.mkdirs();
	}
	try {
	    file.transferTo(new File(parentPath, newName));
	    Map<String, Object> map2 = new HashMap<String, Object>();
	    String src = "upload/face" + "/" + newName;
	    map.put("code", 0);
	    map.put("msg", "上传成功！");
	    map.put("data", map2);
	    map2.put("src", src);
	    map2.put("title", newName);
	    sysuserService.saveFace(src);
	} catch (IOException e) {
	    e.printStackTrace();
	}
	return map;
    }
}
