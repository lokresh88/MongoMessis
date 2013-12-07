package mongoEvalTools;

import java.util.Properties;


public class RunOptions {
	
	public int conn=1;
	
	public Properties props;
	
	RunOptions(){
		props=new Properties();
	}

	public String getProperty(String key){
		return props.getProperty(key);
	}
	
	public void setProperty(String key,String value){
		props.setProperty(key, value);
	}
	
	public Properties getProperties(){
		return props;
	}
	public void validateProps(){
		if(!props.containsKey("recordcount"))
			props.setProperty("recordcount", "10000");
		
			if(!props.containsKey("operationcount"))
			props.setProperty("operationcount", "1000");
		
	/*	if(!props.containsKey("workload"))
			props.setProperty("workload", "com.yahoo.ycsb.workloads.CoreWorkload");
		
		if(!props.containsKey("threads"))
			props.setProperty("threads", "1");*/
		
		if(!props.containsKey("target"))
			props.setProperty("target", "5000");
		
		if(!props.containsKey("fieldcount"))
			props.setProperty("fieldcount", "5");
		
		/*if(!props.containsKey("readallfields"))
			props.setProperty("readallfields", "true");
		
		if(!props.containsKey("readproportion"))
			props.setProperty("readproportion", "0.0");
		
		if(!props.containsKey("updateproportion"))
			props.setProperty("updateproportion", "0.0");
		
		if(!props.containsKey("scanproportion"))
			props.setProperty("scanproportion", "0.0");
		
		if(!props.containsKey("insertproportion"))
			props.setProperty("insertproportion", "0.0");
		
		if(!props.containsKey("requestdistribution"))
			props.setProperty("requestdistribution", "zipfian");
		
		//mongodb props
		
		if(!props.containsKey("mongodb.database"))
			props.setProperty("mongodb.database", "ycsb");
		
		if(!props.containsKey("mongodb.writeConcern"))
			props.setProperty("mongodb.writeConcern", "safe");
		
		if(!props.containsKey("mongodb.maxconnections"))
			props.setProperty("mongodb.maxconnections", "1");*/
		
	
	}
	
	
}
