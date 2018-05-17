package online.shixun.project.module.article.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import online.shixun.project.dto.ArticleDTO;
import online.shixun.project.dto.ArticleTypeDTO;
import online.shixun.project.module.article.dao.ArticleDao;

/**
 * 
 * @author 符杰
 * @date 2018-2-18
 */
@Service("articleService")
@Transactional(rollbackFor = Exception.class)
public class ArticleService {
    @Autowired
    private ArticleDao articleDao;

    public void add(ArticleDTO articleDTO) {
	articleDao.add(articleDTO);
    }

    public List<ArticleDTO> getArticleDTOs() {
	return articleDao.selectNews();
    }

    public List<ArticleTypeDTO> getArticleTypes() {
	return articleDao.selectType();
    }

    public void delete(int id) {
	ArticleDTO articleDTO = new ArticleDTO();
	articleDTO.setId(id);
	articleDao.delete(articleDTO);
    }

    public void deletes(String ids) {
	String[] strs = ids.split(",");
	int[] nums = new int[strs.length];
	for (int i = 0; i < strs.length; i++) {
	    if (strs[i] != null) {
		nums[i] = Integer.parseInt(strs[i]);
		articleDao.deletes(nums[i]);
	    }
	}
    }

    public ArticleDTO getbyId(int id) {
	return articleDao.getArticlebyId(id);
    }

    public void change(int id, int islook) {
	articleDao.changeLook(id, islook);
    }
}
