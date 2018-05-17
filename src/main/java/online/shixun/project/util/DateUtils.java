package online.shixun.project.util;

import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

/**
 * 日期处理工具类
 * 
 * @author QingShiXun
 * 
 * @version 1.0
 */
public class DateUtils {

    private static Log log = LogFactory.getLog(DateUtils.class);

    //默认年月格式(如：2016-06)
    public final static String DEFAULT_MONTH_PATTERN = "yyyy-MM";

    //默认年月日格式(如：2016-06-26)
    public final static String DEFAULT_DATE_PATTERN = "yyyy-MM-dd";

    //默认年月 时间格式(如：2016-06-26 12:12:12)
    public final static String DEFAULT_DATETIME_PATTERN = "yyyy-MM-dd HH:mm:ss";

    public static Date getSysDateNoPattern() {
        return new Date(System.currentTimeMillis());
    }

    /**
     * 获取当前系统时间
     * @return
     */
    public static Timestamp getSysTimestamp() {
        return new Timestamp(System.currentTimeMillis());
    }

    /**
     * 获取当前系统日期
     * @return
     */
    public static Date getSysDate() {
        return stringToDate(getSysDateTimeString(), DEFAULT_DATE_PATTERN);
    }

    /**
     * 获取当前系统日期+时间
     * @return
     */
    public static Date getSysDateTime() {
        return stringToDate(getSysDateTimeString(), DEFAULT_DATETIME_PATTERN);
    }

    public static Date getSysDate(String pattern) {
        return stringToDate(getSysDateTimeString(), pattern);
    }

    public static String getSysDateString() {
        return dateToString(getSysDateNoPattern(), DEFAULT_DATE_PATTERN);
    }

    public static String getSysDateString(String pattern) {
        return dateToString(getSysDateNoPattern(), pattern);
    }

    public static String getSysDateTimeString() {
        return dateToString(getSysDateNoPattern(), DEFAULT_DATETIME_PATTERN);
    }

    public static String getSysDateTimeString(String pattern) {
        return dateToString(getSysDateNoPattern(), pattern);
    }

    public static final String dateToString(Date date) {
        return dateToString(date, DEFAULT_DATE_PATTERN);
    }

    public static final String timeToString(Date date) {
        return dateToString(date, DEFAULT_DATETIME_PATTERN);
    }

    public static final String dateToString(Date date, String pattern) {
        return new SimpleDateFormat(pattern).format(date);
    }

    public static final Date stringToDate(String dateStr) {
        return stringToDate(dateStr, DEFAULT_DATE_PATTERN);
    }

    public static final Date stringToDateTime(String dateStr) {
        return stringToDate(dateStr, DEFAULT_DATETIME_PATTERN);
    }

    public static final Date getSysDateNoTime() {
        String datestr = dateToString(getSysDateNoPattern(), DEFAULT_DATE_PATTERN);
        return stringToDate(datestr, DEFAULT_DATE_PATTERN);
    }

    public static final Date stringToDate(String dateStr, String pattern) {
        try {
            return new SimpleDateFormat(pattern).parse(dateStr);
        } catch (ParseException e) {
            log.error(e.getMessage(), e);
            throw new RuntimeException(e);
        }
    }
}

