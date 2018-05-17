package online.shixun.project.module.article.action;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import online.shixun.project.dto.ArticleDTO;
import online.shixun.project.module.article.service.ArticleService;
import online.shixun.project.web.BaseController;

@Controller
@RequestMapping("/article")
public class ArticleController extends BaseController {
    @Autowired
    private ArticleService articleService;

    @RequestMapping(value = "/list", method = RequestMethod.GET)
    public String articlelist() {
	logger.info("文章首页");
	return "/article/list";
    }

    /**
     * 添加文章
     * 
     * @param model
     * @return
     */
    @RequestMapping("/add")
    public String add(Model model) {
	logger.info("进入添加页面");
	model.addAttribute("type", articleService.getArticleTypes());
	return "/article/add";
    }

    /**
     * 文章添加
     * 
     * @param articleDTO
     * @return
     */
    @RequestMapping(value = "/save")
    @ResponseBody
    public String save(ArticleDTO articleDTO) {
	logger.info("保存新增的文章");
	articleService.add(articleDTO);
	return "success";
    }

    /**
     * 获取文章列表
     * 
     * @return 返回json格式数据
     */
    @RequestMapping(value = "/getArticle", method = RequestMethod.GET)
    @ResponseBody
    public List<ArticleDTO> articleList() {
	logger.info("获取文章列表");
	return articleService.getArticleDTOs();
    }

    /**
     * 删除单条记录
     * 
     * @param id
     * @return
     */
    @RequestMapping(value = "/delete", method = RequestMethod.POST)
    @ResponseBody
    public String deleteArticleById(@RequestParam("id") int id) {
	logger.info("删除文章" + id);
	articleService.delete(id);
	return "success";
    }

    /**
     * 批量删除文章
     * 
     * @param ids
     * @return
     */
    @RequestMapping(value = "/deletes{ids}", method = RequestMethod.POST)
    @ResponseBody
    public String deleteArticleByids(@RequestParam("ids") String ids) {
	logger.info("批量删除" + ids);
	articleService.deletes(ids);
	return "success";
    }

    /**
     * 添加或编辑
     * 
     * @param id
     * @param model
     * @return 添加或编辑页面
     */
    @RequestMapping(value = "/edit")
    public String add(@RequestParam("id") Integer id, Model model) {
	logger.info("编辑文章id为" + id);
	model.addAttribute("articlelist", articleService.getbyId(id));
	model.addAttribute("type", articleService.getArticleTypes());
	return "/article/add";
    }

    /**
     * 查看文章详细信息
     * 
     * @param id
     * @param model
     * @return
     */
    @RequestMapping(value = "/show", method = RequestMethod.GET)
    public String show(@RequestParam("id") Integer id, Model model) {
	logger.info("查看文章详情" + id);
	model.addAttribute("articlelist", articleService.getbyId(id));
	System.out.println(articleService.getbyId(id).getType());
	return "/article/show";
    }

    /**
     * 修改浏览权限
     * 
     * @param id
     * @param model
     * @return
     */
    @RequestMapping(value = "/change", method = RequestMethod.POST)
    @ResponseBody
    public String changelook(@RequestParam("id") Integer id, @RequestParam("islook") Integer islook, Model model) {
	logger.info("修改了id为的权限" + id);
	articleService.change(id, islook);
	return "success";
    }
}
