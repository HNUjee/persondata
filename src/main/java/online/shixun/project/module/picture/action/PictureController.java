package online.shixun.project.module.picture.action;

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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import online.shixun.project.dto.PictureCategoryDTO;
import online.shixun.project.dto.PictureDTO;
import online.shixun.project.module.picture.service.PictureService;
import online.shixun.project.module.picturecategory.service.PictureCategoryService;

@Controller
@RequestMapping("/picture")
public class PictureController {
    @Autowired
    private PictureService pictureService;
    @Autowired
    private PictureCategoryService pictureCategoryService;
    public Logger logger = LoggerFactory.getLogger(getClass());

    @RequestMapping("/list")
    public String picIndex(Model model) {
	logger.info("进入图片列表页面");
	model.addAttribute("categorys", pictureCategoryService.categoryList());
	model.addAttribute("picturelist", pictureService.picList());
	return "/picture/imglist";
    }

    @RequestMapping("/add")
    public String pictureAdd(Model model) {
	logger.info("进入图片添加页面");
	model.addAttribute("categorys", pictureCategoryService.categoryList());
	return "/picture/img";
    }

    /**
     * 获取所有图片
     * 
     * @param model
     * @return
     */
    @RequestMapping("/getpicture")
    @ResponseBody
    public List<PictureDTO> list(Model model) {
	logger.info("获取所有的图片页面");
	model.addAttribute("picturelist", pictureService.picList());
	return pictureService.picList();
    }

    /**
     * 统计图片记录数
     * 
     * @param model
     * @return
     */
    @RequestMapping("/getCountpicture")
    @ResponseBody
    public int countPicture(Model model) {
	logger.info("获取所有记录");
	return pictureService.queryAllcount();
    }

    /**
     * 
     * @param model
     * @param request
     * @return
     */
    @RequestMapping("/select")
    public String name(Model model, HttpServletRequest request) {
	String id = request.getParameter("id");
	model.addAttribute("categorys", pictureCategoryService.categoryList());
	model.addAttribute("picturelist", pictureService.selectList(Integer.parseInt(id)));
	return "/picture/selectlist";
    }

    /**
     * 图片上传
     * 
     * @param file
     * @param request
     * @return
     * @throws IOException
     */
    @RequestMapping("/imgupload")
    @ResponseBody
    public Object img(@RequestParam(required = false) MultipartFile file, HttpServletRequest request)
	    throws IOException {
	Map<String, String> map = new HashMap<String, String>();
	// 获取图片的原名字
	String uid = request.getParameter("uid");
	if (file != null && !file.isEmpty() && uid != null) {
	    String oldName = file.getOriginalFilename();
	    // 截取图片的类型
	    String fileType = oldName.substring(oldName.lastIndexOf("."));
	    // 获取UUID作为新的图片名字 并加上后缀
	    String timeName = UUID.randomUUID().toString().replaceAll("-", "");
	    // 新的图片名称
	    String newName = timeName + fileType;
	    // 获取项目的路径 在项目路径下新建文件夹
	    String path = request.getSession().getServletContext().getRealPath("/upload/picture");
	    // 新建 upload 文件夹 不存在就新建
	    File parentPath = new File(path);
	    if (!parentPath.exists()) {
		parentPath.mkdirs();
	    }
	    PictureDTO picture = new PictureDTO();
	    PictureCategoryDTO category = new PictureCategoryDTO();
	    int ids = Integer.parseInt(uid);
	    category.setId(ids);
	    picture.setImageFileName(newName);
	    String src = "upload/picture/" + newName;
	    picture.setSrcpath(src);
	    picture.setPictureCategory(category);
	    pictureService.addpicture(picture);
	    try {
		file.transferTo(new File(parentPath, newName));
	    } catch (IllegalStateException e) {
		e.printStackTrace();
	    }
	    return false;
	}
	return map;
    }

}
