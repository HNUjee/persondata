package online.shixun.project.module.picturecategory.action;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import online.shixun.project.dto.PictureCategoryDTO;
import online.shixun.project.module.picturecategory.service.PictureCategoryService;

@Controller
@RequestMapping("/pictureCategory")
public class PictureCategoryController {
    @Autowired
    private PictureCategoryService pictureCategoryService;

    @RequestMapping("/add")
    public String pictureCategoryadd() {
	return "/pictureCategory/add";
    }

    @RequestMapping("/save")
    @ResponseBody
    public String categorySaveOrUpdate(PictureCategoryDTO pictureCategory) {
	pictureCategoryService.add(pictureCategory);
	return "success";
    }

    @RequestMapping("/getCategorys")
    @ResponseBody
    public String getCategorys(Model model) {
	model.addAttribute("categorys", pictureCategoryService.categoryList());
	return "success";
    }
}
