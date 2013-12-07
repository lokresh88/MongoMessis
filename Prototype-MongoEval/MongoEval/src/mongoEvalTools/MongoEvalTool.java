package mongoEvalTools;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.InetSocketAddress;
import java.util.concurrent.Executor;
import java.util.logging.Logger;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;

import com.sun.net.httpserver.HttpContext;
import com.sun.net.httpserver.HttpHandler;
import com.sun.net.httpserver.HttpServer;

public class MongoEvalTool extends HttpServlet {
	private static final Logger log = Logger.getLogger(MongoEvalTool.class
			.getName());

	public void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws IOException, ServletException {
		String rc = req.getParameter("rc") != null ? req.getParameter("rc")
				: null;
		String fc = req.getParameter("fc") != null ? req.getParameter("fc")
				: null;
		String tgt = req.getParameter("tgt") != null ? req.getParameter("tgt")
				: null;
		System.out.print("test");

		ShellHandler sh = new ShellHandler();
		RunOptions options = new RunOptions();
		
		if (rc != null)
			options.setProperty("recordcount", rc);

		if (fc != null)
			options.setProperty("fieldcount", fc);

		if (tgt != null)
			options.setProperty("target", tgt);

		sh.setOptions(options);
		
		try {
			sh.start();
			sh.join();
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		JSONArray json = sh.getResult();
		System.out.println(json);
		PrintWriter pw= resp.getWriter();
		pw.print(json+"");

	}

}
