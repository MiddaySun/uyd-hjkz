package uyd.entity;

import java.sql.Timestamp;

import lombok.Data;

/**
 * @author CC , Asa4CC@126.com
 * @time 2020年3月20日,上午10:36:45
 * @version 1.0
 * @description
 */
@Data
public class WsdData {

	private String wsdDataId;
	private String devId;
	private String devArea;
	private String wdValue;
	private String sdValue;
	private Timestamp saveDatetime;

}
