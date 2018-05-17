package online.shixun.project.module.contacttype.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import online.shixun.project.dto.ContactCategoryDTO;
import online.shixun.project.module.contacttype.dao.ContactTypeDao;

@Service("contactTypeService")
@Transactional
public class ContactTypeService {
    @Autowired
    private ContactTypeDao contactTypeDao;

    public void save(ContactCategoryDTO categoryDTO) {
	contactTypeDao.save(categoryDTO);
    }

    public List<ContactCategoryDTO> categoryList() {
	return contactTypeDao.categorylist();
    }

    public void delete(Integer id) {
	ContactCategoryDTO categoryDTO = new ContactCategoryDTO();
	categoryDTO.setId(id);
	contactTypeDao.delete(categoryDTO);
    }

    public ContactCategoryDTO getCategoryById(int id) {
	return contactTypeDao.getCategoryById(id);
    }

    public void deletes(String ids) {
	String[] strs = ids.split(",");
	int[] nums = new int[strs.length];
	for (int i = 0; i < strs.length; i++) {
	    if (strs[i] != null) {
		nums[i] = Integer.parseInt(strs[i]);
		contactTypeDao.deletes(nums[i]);
	    }
	}
    }

    public boolean checkContactType(int id) {
	contactTypeDao.deletes(id);
	return false;
    }
}
