package online.shixun.project.module.articletype.action;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import online.shixun.project.dto.ArticleTypeDTO;
import online.shixun.project.module.articletype.service.ArticleTypeService;

@Controller
@RequestMapping("/articletype")
public class ArticleTypeController {
    @Autowired
    private ArticleTypeService articleTypeService;

    @RequestMapping("/list")
    public String articleTypelist(Model model) {
	return "/articletype/list";
    }

    @RequestMapping(value = "/gettypelist", method = RequestMethod.GET)
    @ResponseBody
    public List<ArticleTypeDTO> articleTypelist() {
	return articleTypeService.articleTypelist();
    }

    /**
     * 进入到添加页面
     * 
     * @return 添加页面
     */
    @RequestMapping("/add")
    public String articletypeadd() {
	return "/articletype/add";
    }

    /**
     * 保存提交的信息
     * 
     * @RequestBody 接受json格式数据
     * @param articleTypeDTO
     * @return
     */
    @RequestMapping(value = "/save")
    @ResponseBody
    public String save(@RequestBody ArticleTypeDTO articleTypeDTO) {
	articleTypeService.add(articleTypeDTO);
	return "success";
    }

    @RequestMapping("/delete")
    @ResponseBody
    public String delete(@RequestParam("id") int id) {
	try {
	    articleTypeService.delete(id);
	} catch (Exception e) {
	    return "error";
	}
	return "success";
    }

    @RequestMapping("/edit")
    public String edit(@RequestParam("id") Integer id, Model model) {
	model.addAttribute("type", articleTypeService.getArticleTypeById(id));
	return "/articletype/add";
    }

    /**
     * 批量删除类型
     * 
     * @param ids
     * @return
     */
    @RequestMapping(value = "/deletes{ids}", method = RequestMethod.POST)
    @ResponseBody
    public String deleteByIds(@RequestParam("ids") String ids) {
	articleTypeService.deletes(ids);
	return "success";
    }
}
