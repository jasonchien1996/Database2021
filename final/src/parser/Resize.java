import java.util.Scanner;

public class Resize {
    public Resize(){}
	public static String parse(String line) throws Exception{
		Scanner s = new Scanner(line);
		float prob, w, h;
		try{
			prob = s.nextFloat();
			s.next();
			w = s.nextFloat();
			h = s.nextFloat();
			if(prob > 1 || s.hasNext())
				throw new Exception();
		} 
		finally{
			s.close();
		}
		String code = String.format("if(((float)(rand()%%100))/100.0 < %s) tmp = __resize(tmp,%s,%s);\n", prob, w, h);
		return code;
	}
}