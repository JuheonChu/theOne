package com.project.util;

import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;

import org.apache.log4j.Logger;

public class Log  {

	public void Logging(Logger log) throws IOException {
		BufferedWriter bw = new BufferedWriter(new FileWriter("Logging.txt", true));
		PrintWriter pw = new PrintWriter(bw, true);
	
		pw.println(log);
	}
}
