package online.shixun.project.module.contact.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import online.shixun.project.dto.ContactDTO;
import online.shixun.project.module.contact.service.ContactService;
import online.shixun.project.module.contacttype.service.ContactTypeService;

@Controller
@RequestMapping("/contact")
public class ContactController {
    protected Logger logger = LoggerFactory.getLogger(getClass());
    @Autowired
    private ContactService contactService;

    @Autowired
    private ContactTypeService contactTypeService;

    @RequestMapping("/list")
    public String contactIndex() {
	logger.info("进入到联系人列表界面");
	return "/contact/list";
    }

    @RequestMapping("/add")
    public String contactAdd(Model model, @RequestParam(defaultValue = "0") int id) {
	logger.info("进入到联系人添加界面");
	model.addAttribute("category", contactTypeService.categoryList());
	if (id != 1) {
	    model.addAttribute("contact", contactService.getContactById(id));
	}
	return "/contact/add";
    }

    @RequestMapping("/save")
    @ResponseBody
    public String save(ContactDTO contact, @RequestParam(required = false) MultipartFile file,
	    HttpServletRequest request) {
	logger.info("保存联系人信息-->" + contact);
	contactService.saveOrupdate(contact);
	return "success";
    }

    /**
     * 获取所有联系人
     * 
     * @return json格式数据
     */
    @RequestMapping(value = "/getContact", method = RequestMethod.GET)
    @ResponseBody
    public List<ContactDTO> contactList() {
	return contactService.contactList();
    }

    /**
     * 删除联系人
     * 
     * @param model
     * @param id
     *            联系人id
     * @return
     */
    @RequestMapping(value = "/delete")
    @ResponseBody
    public String deleteContact(Model model, Integer id) {
	logger.info("删除");
	contactService.delete(id);
	return "success";
    }

    /**
     * 批量删除 联系人
     * 
     * @param ids
     * @return
     */
    @RequestMapping(value = "/deletes")
    @ResponseBody
    public String deletesContact(@RequestParam("ids") String ids) {
	logger.info("删除");
	contactService.deletes(ids);
	return "success";
    }
}
