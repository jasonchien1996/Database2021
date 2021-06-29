import java.util.Scanner;

public class Medianblur {
    public Medianblur(){}
	public static String parse(String line) throws Exception{
		Scanner s = new Scanner(line);
		float prob;
		int ksize;
		try{
			prob = s.nextFloat();
			s.next();
			ksize = s.nextInt();
			if(prob > 1 || s.hasNext())
				throw new Exception();
		} 
		finally{
			s.close();
		}
		String code = String.format("if(((float)(rand()%%100))/100.0 < %s) tmp = __medianblur(tmp,%s);\n", prob, ksize);
		return code;
	}
}
