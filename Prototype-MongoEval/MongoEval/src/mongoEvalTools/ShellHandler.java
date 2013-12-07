package mongoEvalTools;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;


public class ShellHandler extends Thread{

	private final static String SHELL_DIR="/home/lokesh/Desktop/YCSB";
	private final static String SHELL_NAME="runExpJava.sh";
	
	private RunOptions options;
	private JSONArray result;
	
	public void setOptions(RunOptions options){
		this.options = options;
	}
	
	public RunOptions getOptions(){
		return options;
	}
	
	public JSONArray getResult(){
		return result;
	}
	
	@Override
	public void run() {
		if(options==null) {
			options=new RunOptions();
			
		}
		
		options.validateProps();
		
		File baseDir = new File(SHELL_DIR+File.separator+"Base");
		baseDir.mkdir();
		File propsFile = new File(baseDir, "workload.dat");
		PrintWriter pw = null;
		try {
			propsFile.createNewFile();
			pw = new PrintWriter(propsFile);
			options.getProperties().store(pw, "auto-generatred props");
			
		} catch (Exception e1) {
			e1.printStackTrace();
		}
		
		ProcessBuilder pb = new ProcessBuilder(SHELL_DIR+File.separator+SHELL_NAME, propsFile.getAbsolutePath());
		pb.directory(new File(SHELL_DIR));
		try {
			Process p = pb.start();
			p.waitFor();
			
			BufferedReader br=null;
			File resultFile = new File(baseDir, "w-consol.txt");
			if(resultFile.exists()){
				br = new BufferedReader(new FileReader(resultFile));
			}
			String line="";
			JSONArray res = new JSONArray();
			while ((line = br.readLine()) != null) {  
				  
			    String[] values = line.split(",");  
			    JSONObject obj = new JSONObject();
			    System.out.println(line+" -------ResLine");
				 
			    
			    Map<String,String> map = new HashMap<String,String>();
			//    map.put("Connections", values[0]);
			    map.put("0", values[0]);
			    map.put("1", values[1]);
			    map.put("2", values[2]);
			    map.put("3", values[3]);
			    String value4="0";
			    try{
			    	Double dbl = Double.parseDouble(values[4]);
			    	Double dbl2 = Double.parseDouble(options.getProperty("operationcount"));
			    	dbl=dbl*100/dbl2;
			    	value4=String.valueOf(dbl);
			    }catch(Exception e){
			    	
			    }
			    map.put("4", value4);
			 /*   map.put("Threads", values[6]);
			    map.put("Target", values[7]);			    
			    map.put("Comments", values[8]);
			 */   //obj.put("Result", map);
			 System.out.println(obj+" -------Res");
			    res.add(new JSONObject(map));
			   
			   }  
			JSONArray chts = new JSONArray();
			JSONArray cht = new JSONArray();
			cht.add(new JSONObject(constructSeriesCol(res, "Read", "#00FF00", 0)));
			cht.add(new JSONObject(constructSeriesCol(res, "Update", "#0000FF", 1)));
			cht.add(new JSONObject(constructSeriesCol(res, "Insert", "#FF0000", 2)));
			cht.add(new JSONObject(constructSeriesCol(res, "RMW", "#FFFF00", 3)));
			
			JSONArray cht2= new JSONArray();
			cht2.add(new JSONObject(constructSeriesCol(res, "Thput", "#00FFFF", 4)));
			
			chts.add(cht);
			chts.add(cht2);
			
			System.out.println(chts);
			result = chts;
			// notify();
		} catch (Exception e) {
			
		}
		
		
	}
	public Map<String,String> constructSeriesCol(JSONArray res,String title,String color,int index){
		
		Map map = new HashMap();
		map.put("type", "column");
		map.put("title", title);
		map.put("fillStyle", color);
		JSONArray data = new JSONArray();
		ArrayList dataMap = new ArrayList();
		
		ArrayList dataMap1 = new ArrayList();
		ArrayList dataMap2 = new ArrayList();
		ArrayList dataMap3 = new ArrayList();
		ArrayList dataMap4 = new ArrayList();
		ArrayList dataMap5 = new ArrayList();
		
		dataMap1.add("A");
		dataMap1.add(Double.parseDouble((String) ((JSONObject) res.get(0)).get(String.valueOf(index))));
		
		dataMap2.add("B");
		dataMap2.add(Double.parseDouble((String) ((JSONObject) res.get(1)).get(String.valueOf(index))));
		
		dataMap3.add("C");
		dataMap3.add(Double.parseDouble((String) ((JSONObject) res.get(2)).get(String.valueOf(index))));
		
		dataMap4.add("D");
		dataMap4.add(Double.parseDouble((String) ((JSONObject) res.get(3)).get(String.valueOf(index))));
		
		dataMap5.add("E");
		dataMap5.add(Double.parseDouble((String) ((JSONObject) res.get(4)).get(String.valueOf(index))));
		
		dataMap.add(dataMap1);		
		dataMap.add(dataMap2);		
		dataMap.add(dataMap3);		
		dataMap.add(dataMap4);		
		dataMap.add(dataMap5);		
		
		/*dataMap.put("A", (String) ((JSONObject) res.get(0)).get(String.valueOf(index)));
		dataMap.put("B", (String) ((JSONObject) res.get(1)).get(String.valueOf(index)));
		dataMap.put("C", (String) ((JSONObject) res.get(2)).get(String.valueOf(index)));
		dataMap.put("D", (String) ((JSONObject) res.get(3)).get(String.valueOf(index)));
		dataMap.put("E", (String) ((JSONObject) res.get(4)).get(String.valueOf(index)));
		*/
		//data.add(new JSONObject(dataMap));
		map.put("data", dataMap);
		//obj.put("therla", map);
		return map;
	}
	
}
