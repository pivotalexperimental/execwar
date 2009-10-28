package com.pivotallabs.execwar;

// Jetty imports
import org.eclipse.jetty.server.Server;
import org.eclipse.jetty.servlet.ServletContextHandler;
import org.eclipse.jetty.servlet.ServletHolder;
import org.eclipse.jetty.servlet.FilterHolder;

// JRuby imports
import org.jruby.rack.RackServlet;
import org.jruby.rack.RackFilter;
import org.jruby.rack.rails.RailsServletContextListener;
import org.eclipse.jetty.util.resource.Resource;

// Java imports
import java.util.Map;
import java.util.HashMap;
import java.net.URL;

public class Main {
  public static void main(String[] args) throws Exception {
    Server server = new Server(8080);

    ServletContextHandler context = new ServletContextHandler(ServletContextHandler.SESSIONS);
    
    context.setContextPath("/");

    Map<String,String> initParams = new HashMap<String,String>();
    // initParams.put("rails.root", "WEB-INF");
    initParams.put("rails.env", "development");
    initParams.put("jruby.min.runtimes","1");
    initParams.put("jruby.max.runtimes","1");
    context.setInitParams(initParams);

    context.setResourceBase("");

    server.setHandler(context);

    context.addServlet(new ServletHolder(new RackServlet()),"/*");

    context.addEventListener(new RailsServletContextListener());

    server.start();
    server.join();
  }
}
