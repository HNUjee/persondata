package online.shixun.project.module.link.action;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import online.shixun.project.dto.LinkDTO;
import online.shixun.project.module.link.service.LinkService;
import online.shixun.project.web.BaseController;

@Controller
@RequestMapping("/link")
public class LinkController extends BaseController {
    @Autowired
    private LinkService linkService;

    /**
     * 进入链接主页面
     * 
     * @return
     */
    @RequestMapping("/list")
    public String link() {
	logger.info("链接页面");
	return "/links/linksList";
    }

    /**
     * 
     * @return 链接添加页面
     */
    @RequestMapping("/add")
    public String linksAdd() {
	logger.info("添加页面");
	return "/links/linksAdd";
    }

    /**
     * 
     * @return 链接列表json格式
     */
    @RequestMapping(value = "/getlinks", method = RequestMethod.GET)
    @ResponseBody
    public List<LinkDTO> getlinkList() {
	logger.info("获取链接列表");
	return linkService.linklist();
    }

    /**
     * 保存新增链接
     * 
     * @param linkDTO
     * @return
     */
    @RequestMapping(value = "/save", method = RequestMethod.POST)
    @ResponseBody
    public String addLinks(@RequestBody LinkDTO linkDTO) {
	logger.info("保存新增链接");
	linkService.add(linkDTO);
	return "success";
    }

    /**
     * 根据id删除链接
     * 
     * @param id
     * @return
     */
    @RequestMapping(value = "/delete", method = RequestMethod.POST)
    @ResponseBody
    public String deleteLink(@RequestParam("id") int id) {
	logger.info("删除了link id=" + id);
	linkService.delete(id);
	return "success";
    }

    /**
     * 根据id批量删除链接
     * 
     * @param ids
     * @return
     */
    @RequestMapping(value = "/deletes{ids}", method = RequestMethod.POST)
    @ResponseBody
    public String deleteArticleByids(@RequestParam("ids") String ids) {
	logger.info("批量删除" + ids);
	linkService.deletes(ids);
	return "success";
    }

    /**
     * 根据id编辑
     * 
     * @param id
     * @param model
     * @return
     */
    @RequestMapping(value = "/edit")
    public String edit(@RequestParam("id") int id, Model model) {
	logger.info("编辑 id为 " + id);
	model.addAttribute("link", linkService.getbyId(id));
	return "/links/linksAdd";
    }
}
