package online.shixun.project.web;

import java.io.IOException;
import java.util.Date;
import java.util.Iterator;
import java.util.LinkedList;

import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import online.shixun.project.dto.PictureCategoryDTO;

@Controller
@RequestMapping("/controller")
public class FileController {

    LinkedList<PictureCategoryDTO> files = new LinkedList<PictureCategoryDTO>();
    PictureCategoryDTO fileMeta = null;

    /***************************************************
     * URL: /rest/controller/upload upload(): receives files
     * 
     * @param request
     *            : MultipartHttpServletRequest auto passed
     * @param response
     *            : HttpServletResponse auto passed
     * @return LinkedList<FileMeta> as json format
     * @throws IOException
     ****************************************************/
    @RequestMapping(value = "/upload", method = RequestMethod.POST)
    public @ResponseBody LinkedList<PictureCategoryDTO> upload(MultipartHttpServletRequest request,
	    HttpServletResponse response) throws IOException {

	// 1. build an iterator
	Iterator<String> itr = request.getFileNames();
	MultipartFile mpf = null;

	// 2. get each file
	while (itr.hasNext()) {

	    // 2.1 get next MultipartFile
	    mpf = request.getFile(itr.next());
	    System.out.println(mpf.getOriginalFilename() + " uploaded! " + files.size());

	    // 2.2 if files > 10 remove the first from the list
	    if (files.size() >= 10)
		files.pop();
	    // 2.3 create new fileMeta
	    fileMeta = new PictureCategoryDTO();
	    fileMeta.setCreateTime(new Date());
	    fileMeta.setName("1");
	}
	// result will be like this
	// [{"fileName":"app_engine-85x77.png","fileSize":"8
	// Kb","fileType":"image/png"},...]
	return files;

    }

    /***************************************************
     * URL: /rest/controller/get/{value} get(): get file as an attachment
     * 
     * @param response
     *            : passed by the server
     * @param value
     *            : value from the URL
     * @return void
     ****************************************************/
    @RequestMapping(value = "/get/{value}", method = RequestMethod.GET)
    public void get(HttpServletResponse response, @PathVariable String value) {
	PictureCategoryDTO getFile = files.get(Integer.parseInt(value));
	response.setContentType(getFile.getDescription());
	response.setHeader("Content-disposition", "attachment; filename=\"" + getFile.getDescription() + "\"");
	// FileCopyUtils.copy(getFile.getBytes(), response.getOutputStream());
    }

}
