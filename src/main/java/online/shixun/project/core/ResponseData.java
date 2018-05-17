/*****************************************************************************
 * Copyright (c) 2015, www.qingshixun.com
 *
 * All rights reserved
 *
 *****************************************************************************/
package online.shixun.project.core;

import java.io.Serializable;

/**
 * 操作请求响应返回数据
 * 
 * @author QingShiXun
 * 
 * @version 1.0
 */
public class ResponseData implements Serializable {

    //操作成功
    private static final String SUCCESS_CODE = "0";

    //操作失败
    private static final String ERROR_CODE = "-1";

    private String status = SUCCESS_CODE;

    //返回数据
    private Object data;

    public boolean isSuccess() {
        return this.status.equalsIgnoreCase(SUCCESS_CODE) ? true : false;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Object getData() {
        return data;
    }

    public void setData(Object data) {
        this.data = data;
    }

    public void setError(Object data) {
        this.status = ERROR_CODE;
        this.data = data;
    }

    public void setError(String status, Object data) {
        this.status = status;
        this.data = data;
    }
}

