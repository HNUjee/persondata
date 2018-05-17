package online.shixun.project.module.contacttype.action;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import online.shixun.project.dto.ContactCategoryDTO;
import online.shixun.project.module.contacttype.service.ContactTypeService;

@Controller
@RequestMapping("/contactType")
public class ContactTypeController {
    protected Logger logger = LoggerFactory.getLogger(getClass());
    @Autowired
    private ContactTypeService contactTypeService;

    @RequestMapping(value = "/list")
    public String contactIndex() {
	logger.info("首页");
	return "/contact/contactType/list";
    }

    @RequestMapping(value = "/add")
    public String typeadd() {
	logger.info("进入到添加页面");
	return "/contact/contactType/add";
    }

    @RequestMapping(value = "/save", method = RequestMethod.POST)
    @ResponseBody
    public String saveOrUpdate(ContactCategoryDTO categoryDTO) {
	logger.info("添加分类");
	contactTypeService.save(categoryDTO);
	return "success";
    }

    @RequestMapping(value = "/getCategory", method = RequestMethod.GET)
    @ResponseBody
    public List<ContactCategoryDTO> getCategoryList() {
	logger.info("获取分类列表");
	return contactTypeService.categoryList();
    }

    @RequestMapping(value = "/deleteCategory", method = RequestMethod.POST)
    @ResponseBody
    public ModelAndView deleteCategory(@RequestParam("id") Integer id, Model model) {
	logger.info("删除联系人分类id为--->" + id);
	try {
	    contactTypeService.delete(id);
	} catch (Exception e) {
	    ModelAndView mv = new ModelAndView();
	    mv.setViewName("/error/error");
	    return mv;
	}
	return new ModelAndView();
    }

    @RequestMapping(value = "/deletesCategory", method = RequestMethod.POST)
    @ResponseBody
    public String deletesCategory(@RequestParam("ids") String ids) {
	logger.info("删除联系人分类ids为--->" + ids);
	contactTypeService.deletes(ids);
	return "success";
    }

    @RequestMapping(value = "/edit")
    public String editCategory(Model model, int id) {
	logger.info("进入到添加页面");
	model.addAttribute("category", contactTypeService.getCategoryById(id));
	return "/contact/contactType/add";
    }
}
