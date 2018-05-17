package online.shixun.project.module.contact.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import online.shixun.project.dto.ContactDTO;
import online.shixun.project.module.contact.dao.ContactDao;

@Service("contactService")
@Transactional
public class ContactService {
    @Autowired
    private ContactDao contactDao;

    public void saveOrupdate(ContactDTO contact) {
	contactDao.save(contact);
    }

    public List<ContactDTO> contactList() {
	return contactDao.contactList();
    }

    public ContactDTO getContactById(int id) {
	return contactDao.getContactById(id);
    }

    public void delete(int id) {
	ContactDTO contact = new ContactDTO();
	contact.setId(id);
	contactDao.delete(contact);
    }

    public void deletes(String ids) {
	String[] strs = ids.split(",");
	int[] nums = new int[strs.length];
	for (int i = 0; i < strs.length; i++) {
	    if (strs[i] != null) {
		nums[i] = Integer.parseInt(strs[i]);
		contactDao.deletes(nums[i]);
	    }
	}

    }
}
